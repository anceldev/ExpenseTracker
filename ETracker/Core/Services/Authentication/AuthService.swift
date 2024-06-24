//
//  AuthService.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Firebase
import FirebaseAuth

@MainActor
class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @MainActor
    func signInWithEmailPassword(email: String, password: String) async throws -> FirebaseAuth.User? {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("DEBUG: User signed in \(result.user.email ?? "UNKNOWN")")
            return result.user
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
            return nil
        }
    }
    
    @MainActor
    func signUpWithEmailPassword(email: String, password: String, fullname: String, username: String) async throws -> FirebaseAuth.User? {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG: User created: \(result.user.email ?? "UNKNOWN")")
            return result.user
        } catch {
            print("DEBUG: Failed to create new user: \(error.localizedDescription)")
            return nil
        }
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            print("DEBUG - Failed signing out account")
            return false
        }
    }
}
