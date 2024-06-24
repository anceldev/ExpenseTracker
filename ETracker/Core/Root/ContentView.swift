//
//  ContentView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct ContentView: View {
    
//    @Environment(AuthenticationViewModel.self) private var authViewModel
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationStack {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                SignInView()
            case .authenticating:
                ProgressView()
            case .authenticated:
                MainTab {
                    ProfileBar(name: authViewModel.user?.displayName ?? authViewModel.email, profilePhoto: "profile-test")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationViewModel())
}
