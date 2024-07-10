//
//  ProfileBar.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct ProfileBar: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    let name: String
    let profilePhoto: String
    
    init(name: String = "User", profilePhoto: String = "profile-test") {
        self.name = name
        self.profilePhoto = profilePhoto
    }
    
    var body: some View {
        HStack {
            Image(profilePhoto)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.red.opacity(0), lineWidth: 1)
                }
            Text("Hi, ") +
            Text(name)
                .fontWeight(.semibold)
                
            Spacer()
            HStack(spacing: 15){
                NavigationLink {
                    NotificationsView()
                } label: {
                    Label("Notifications", systemImage: "bell")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.gray900)
                }
                
                Menu {
                    NavigationLink {
                        SettingsView()
                            .environmentObject(viewModel)
                    } label: {
                        Text("Settings")
                    }
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.gray900)
                }
            }
        }
        .fontDesign(.rounded)
        .padding(16)
        
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    ProfileBar()
        .environmentObject(AuthenticationViewModel())
})
