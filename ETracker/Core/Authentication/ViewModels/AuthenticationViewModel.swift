//
//  AuthenticationViewModel.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//


import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth
import Observation

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case signUp
    case recovery
}


final class AuthenticationViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var flow: AuthenticationFlow = .login
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage = ""
    @Published var user: FirebaseAuth.User?
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init(authenticationState: AuthenticationState = .unauthenticated) {
        self.authenticationState = authenticationState
        registerAuthStateHanlder()
    }
    private func registerAuthStateHanlder() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
            })
        }
    }
    private func reset() {
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    @MainActor
    func signInWithEmailPassword() async {
        authenticationState = .authenticating
        do {
            self.user = try await AuthService.shared.signInWithEmailPassword(email: self.email, password: self.password)
            authenticationState = .authenticated
        } catch {
            print("DEBUG: Failed to sign in with AuthService \(error.localizedDescription)")
            authenticationState = .unauthenticated
        }
    }
    
    @MainActor
    func signUpWithEmailPassword() async {
        authenticationState = .authenticating
        do {
            self.user = try await AuthService.shared.signUpWithEmailPassword(email: self.email, password: self.password, fullname: self.fullname, username: self.username)
            authenticationState = .authenticated
        } catch {
            print("DEBUG: Failed to sign up with AuthService \(error.localizedDescription)")
        }
    }
}

