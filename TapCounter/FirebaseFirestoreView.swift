//
//  FirebaseFirestoreView.swift
//  TapCounter
//
//  Created by Nguyen Van Bac on 30/3/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Foundation

struct FirebaseFirestoreView: View {
    @StateObject var viewModel = TaskViewModelDB()
    @State private var newTaskTitle = ""

    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter task", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Add Task") {
                    if !newTaskTitle.isEmpty {
                        viewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            Button(action: {
                                var updatedTask = task
                                updatedTask.completed.toggle()
                                viewModel.updateTask(task: updatedTask)
                            }) {
                                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.completed ? .green : .gray)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let task = viewModel.tasks[index]
                            viewModel.deleteTask(task: task)
                        }
                    }
                }
            }
            .navigationTitle("Firestore Tasks")
            .onAppear {
                print("✅ onAppear triggered")
                viewModel.fetchTasks()
            }
        }
    }
}

struct FirebaseFirestoreView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseFirestoreView()
    }
}


class TaskViewModelDB: ObservableObject {
    @Published var tasks: [Jobs] = []
    private let db = Firestore.firestore().collection("jobs")

    // Fetch tasks from Firestore
    func fetchTasks() {
        db.addSnapshotListener { snapshot, error in
            if let error = error {
                print("❌ Error fetching tasks: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("❌ No tasks found")
                return
            }

            DispatchQueue.main.async {
                self.tasks = documents.compactMap { doc in
                    try? doc.data(as: Jobs.self)
                }
            }
        }
    }

    // Add a new task to Firestore
    func addTask(title: String) {
        let newTask = Jobs(id: UUID().uuidString, title: title, completed: false)
        do {
            try db.document(newTask.id).setData(from: newTask)
            print("✅ Task added: \(title)")
        } catch {
            print("❌ Error adding task: \(error.localizedDescription)")
        }
    }

    // Update a task's completion status
    func updateTask(task: Jobs) {
        let taskRef = db.document(task.id)
        taskRef.updateData(["completed": task.completed]) { error in
            if let error = error {
                print("❌ Error updating task: \(error.localizedDescription)")
            } else {
                print("✅ Task updated: \(task.title) -> \(task.completed ? "Completed" : "Pending")")
            }
        }
    }

    // Delete a task from Firestore
    func deleteTask(task: Jobs) {
        db.document(task.id).delete { error in
            if let error = error {
                print("❌ Error deleting task: \(error.localizedDescription)")
            } else {
                print("✅ Task deleted: \(task.title)")
            }
        }
    }
}


struct Jobs: Identifiable, Codable {
    var id: String  // Firestore document ID
    var title: String
    var completed: Bool
}

