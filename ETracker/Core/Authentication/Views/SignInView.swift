//
//  SignInView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct SignInView: View {
    
    @State private var acceptConditions = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40, content: {
            Text("Login to your\naccount")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.purple700)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    CustomInputField(
                        title: "Email",
                        text: viewModel.email,
                        imageName: "user",
                        autoCorrectionDisabled: true) {
                            TextField("Email", text: $viewModel.email)
                                .textInputAutocapitalization(.never)
                        }
                }
                VStack(alignment: .leading) {
                    CustomInputField(title: "Password", text: viewModel.password, imageName: "key", autoCorrectionDisabled: true) {
                        SecureField("Password", text: $viewModel.password)
                            .textInputAutocapitalization(.never)
                    }
                }
                HStack {
                    Spacer()
                    HStack {
//                        NavigationLink {
//                            RestorePasswordView()
//                                .environmentObject(viewModel)
//                                .navigationBarBackButtonHidden()
//                        } label: {
//                            Text("Forgot your password?")
//                                .foregroundStyle(.purple700)
//                        }
                        Button(action: {
                            withAnimation {
                                viewModel.flow = .recovery                                
                            }
                        }, label: {
                            Text("Forgot your password?")
                                .foregroundStyle(.purple700)
                        })
                    }
                }
                .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            
            FormDivider()
            
            Spacer()
            Button(action: {
                // Sign in button
                viewModel.login()
            }, label: {
                if viewModel.authenticationState == .authenticating {
                    ProgressView()
                } else{
                    Text("Sign In")
                }
            })
            .buttonStyle(.mainButton(purpleButton, stroke: .purple700, shadow: .purple400))
            VStack(alignment: .center) {
                //                NavigationLink {
                //                    SignUpView()
                //                        .navigationBarBackButtonHidden()
                //                        .environmentObject(viewModel)
                //                } label: {
                //                    HStack(alignment: .center) {
                //                        Text("Don't you have an account? ")
                //                            .foregroundStyle(.black)
                //                        +
                //                        Text("Sign up.")
                //                            .foregroundStyle(.purple700)
                //                            .fontWeight(.bold)
                //                    }
                //                    .font(.system(size: 16, design: .rounded))
                //                }
                HStack(alignment: .center) {
                    Text("Don't you have an account? ")
                        .foregroundStyle(.black)
                    Button(action: {
                        withAnimation {
                            viewModel.flow = .signUp
                        }
                    }, label: {
                        Text("Sign up.")
                            .foregroundStyle(.purple700)
                            .fontWeight(.bold)
                    })
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
        })
        .padding()
    }
}

#Preview {
    NavigationStack {
        SignInView()
            .environmentObject(AuthenticationViewModel())
    }
}
