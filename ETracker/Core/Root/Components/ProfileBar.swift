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
            Menu {
                NavigationLink {
                    AccountView()
                        .environmentObject(viewModel)
                } label: {
                    Text("Account")
                }
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.gray900)
            }

//            Button(action: {
//                
//            }, label: {
//                VStack {
//                    Image(systemName: "ellipsis")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 20)
//                        .rotationEffect(.degrees(90))
//                }
//                .frame(width: 40, height: 40)
//                .background(.gray200)
//                .clipShape(Circle())
//                
//            })
//            .foregroundStyle(.black)

        }
        .fontDesign(.rounded)
        .padding(16)
        
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    ProfileBar()
})
