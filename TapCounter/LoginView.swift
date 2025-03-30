//
//  LoginView.swift
//  TapCounter
//
//  Created by Nguyen Van Bac on 30/3/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var userId: String?

    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
            print("✅ Firebase Initialized")
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                if let userId = userId {
                    Text("✅ Logged in as: \(userId)")
                        .foregroundColor(.green)
                        .padding()

                    NavigationLink(destination: SurveyApp()) {
                        Text("Go to Survey")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button("Logout") {
                        logout()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)

                } else {
                    Button("Login Anonymously") {
                        loginAnonymously()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .onAppear {
                checkAuthState()
            }
        }
    }

    // ✅ Check if user is already logged in
    func checkAuthState() {
        if let currentUser = Auth.auth().currentUser {
            userId = currentUser.uid
            print("🔄 Already logged in: \(currentUser.uid)")
        }
    }

    // ✅ Login Anonymously
    func loginAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("❌ Login failed: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                print("✅ Logged in as \(user.uid)")
                userId = user.uid
            }
        }
    }

    // ✅ Logout Function
    func logout() {
        do {
            try Auth.auth().signOut()
            userId = nil
            print("🚪 Logged out successfully")
        } catch {
            print("❌ Logout failed: \(error.localizedDescription)")
        }
    }
}
