//
//  RestorePasswordView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct RestorePasswordView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40, content: {
            Text("Restore\nPassword")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.purple700)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 20, content: {
                VStack(alignment: .leading, content: {
                    CustomInputField(
                        title: "Email",
                        text: viewModel.email,
                        imageName: "mail",
                        autoCorrectionDisabled: true) {
                            TextField("Email", text: $viewModel.email)
                                .textInputAutocapitalization(.never)
                        }
                })
            })
            VStack(alignment: .center) {
                Text("You'll receive an email to recover\nyour password.")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .lineLimit(2, reservesSpace: true)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            Spacer()
            Button(action: {
                // Sign in button
            }, label: {
                Text("Send Email")
            })
            .buttonStyle(.mainButton(purpleButton, stroke: .purple700, shadow: .purple400))
            
            VStack(alignment: .center) {
                HStack(alignment: .center, spacing: 8) {
                    Button(action: {
                        print("Sending email to restore password...")
                        withAnimation {
                            viewModel.flow = .login
                        }
                    }, label: {
                        Text("Sign In.")
                            .foregroundStyle(.purple700)
                            .fontWeight(.bold)
                    })
                }
                .font(.system(size: 16, design: .rounded))
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
        })
        .padding()
    }
}

#Preview {
    RestorePasswordView()
        .environmentObject(AuthenticationViewModel())
}
