//
//  ETrackerApp.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
      /// Firebase Emulator settings
      /// Authentication
//        Auth.auth().useEmulator(withHost: "127.0.0.1", port: 9099)
      
    return true
  }
}

@main
struct ETrackerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
