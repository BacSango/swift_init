//
//  SurveyApp.swift
//  TapCounter
//
//  Created by Nguyen Van Bac on 30/3/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct SurveyApp: View {
    var body: some View {
        NavigationStack {
            NameScreen()
        }
    }
}

// MARK: - Name Screen
struct NameScreen: View {
    @State private var name = ""

    var body: some View {
        VStack {
            Text("Enter your name")
                .font(.title)
            TextField("Your Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            NavigationLink(destination: BirthdayScreen(name: name)) {
                Text("Next")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(name.isEmpty)
        }
        .padding()
    }
}

// MARK: - Birthday Screen
struct BirthdayScreen: View {
    let name: String
    @State private var birthday = Date()

    var body: some View {
        VStack {
            Text("Enter your birthday")
                .font(.title)
            DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            NavigationLink(destination: EmailScreen(name: name, birthday: birthday)) {
                Text("Next")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

// MARK: - Email Screen
struct EmailScreen: View {
    let name: String
    let birthday: Date
    @State private var email = ""
    @State private var isSubmitted = false

    private let db = Firestore.firestore()

    var body: some View {
        VStack {
            Text("Enter your email")
                .font(.title)
            TextField("Your Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Submit") {
                submitSurvey()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(email.isEmpty)

            if isSubmitted {
                Text("✅ Survey submitted successfully!")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }

    func submitSurvey() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("❌ No user logged in")
            return
        }

        let surveyData: [String: Any] = [
            "name": name,
            "birthday": Timestamp(date: birthday),
            "email": email,
            "userId": userId
        ]

        let surveyRef = db.collection("surveys").document(userId)
        print("📌 Saving to Firestore: surveys/\(userId)")

        surveyRef.setData(surveyData) { error in
            if let error = error {
                print("❌ Error saving survey: \(error.localizedDescription)")
            } else {
                print("✅ Survey submitted!")
                isSubmitted = true
            }
        }
    }
}
