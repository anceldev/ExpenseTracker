//
//  SignUpView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var acceptConditions = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40, content: {
            Text("New account?\nSign up")
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .foregroundStyle(.iris600)
            VStack(spacing: 20, content: {
                VStack(alignment: .leading, content: {
                    CustomInputField(title: "Name", text: viewModel.fullname, imageName: "user", autoCorrectionDisabled: true) {
                        TextField("Fullname", text: $viewModel.fullname)
                    }
                })
                VStack(alignment: .leading, content: {
                    CustomInputField(title: "Username", text: viewModel.username, imageName: "atSymbol", autoCorrectionDisabled: true) {
                        TextField("Username", text: $viewModel.username)
                    }
                })
                VStack(alignment: .leading, content: {
                    CustomInputField(
                        title: "Email",
                        text: viewModel.username,
                        imageName: "mail",
                        autoCorrectionDisabled: true) {
                            TextField("Email", text: $viewModel.email)
                                .textInputAutocapitalization(.never)
                        }
                })
                VStack(alignment: .leading, content: {
                    CustomInputField(title: "Password", text: viewModel.username, imageName: "key", autoCorrectionDisabled: true) {
                        SecureField("Password", text: $viewModel.password)
                    }
                })
            })
            Button(action: {
//                dismiss()
                viewModel.signUp()
            }, label: {
                if viewModel.authenticationState == .authenticating {
                    ProgressView()
                } else{
                    Text("Sign Up")
                }
            })
            .buttonStyle(.mainButton())
            VStack(alignment: .center) {
                HStack(alignment: .center, spacing: 8) {
                    Text("Already have an account? ")
                        .foregroundStyle(.black)
                    
                    Button(action: {
                        withAnimation {
                            viewModel.flow = .login
                        }
                    }, label: {
                        Text("Sign In.")
                            .foregroundStyle(.iris600)
                            .fontWeight(.bold)
                    })
                }
                .font(.system(size: 16, design: .rounded))
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
        })
        .padding(22)
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthenticationViewModel())
}
