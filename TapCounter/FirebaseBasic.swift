//
//  FirebaseBasic.swift
//  TapCounter
//
//  Created by Nguyen Van Bac on 30/3/25.
//

import SwiftUI
import Foundation
import FirebaseDatabase
import Firebase



struct FirebaseBasic: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()  // Initialize Firebase if not already configured
        }
        
        let database = Database.database()
            
        //  Check the connection by reading a test value
        let testRef = database.reference(withPath: "test_connection")
        testRef.setValue("ping") { error, _ in
            if let error = error {
                print("❌ Firebase write failed: \(error.localizedDescription)")
            } else {
                print("✅ Firebase write succeeded!")
            }
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
            .navigationTitle("Firebase Tasks")
            .onAppear {
                viewModel.fetchTasks()
            }
        }
    }
}



struct Task: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var completed: Bool
}


class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
     private let ref = Database.database().reference().child("tasks")

    // Fetch data
        func fetchTasks() {
            ref.observe(.value) { snapshot in
                var tempTasks: [Task] = []
                for child in snapshot.children {
                    if let snap = child as? DataSnapshot,
                       let dict = snap.value as? [String: Any],
                       let title = dict["title"] as? String,
                       let completed = dict["completed"] as? Bool {
                        let task = Task(id: snap.key, title: title, completed: completed)
                        tempTasks.append(task)
                    }
                }
                DispatchQueue.main.async {
                    self.tasks = tempTasks
                }
            }
        }

        // Add task
        func addTask(title: String) {
            let newTask = Task(title: title, completed: false)
            let taskRef = ref.child(newTask.id)
            taskRef.setValue(["title": newTask.title, "completed": newTask.completed])
        }

        // Update task
        func updateTask(task: Task) {
            let taskRef = ref.child(task.id)
            taskRef.updateChildValues(["completed": task.completed])
        }

        // Delete task
        func deleteTask(task: Task) {
            let taskRef = ref.child(task.id)
            taskRef.removeValue()
        }
}



