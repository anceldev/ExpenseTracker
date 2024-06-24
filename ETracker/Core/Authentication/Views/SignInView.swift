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
            VStack {
                VStack(alignment: .leading) {
                    CustomInputField(title: "Email", text: viewModel.email, imageName: "user", autoCorrection: false) {
                        TextField("Email", text: $viewModel.email)
                    }
                }
                VStack(alignment: .leading) {
                    CustomInputField(title: "Password", text: viewModel.password, imageName: "key", autoCorrection: true) {
                        SecureField("Password", text: $viewModel.password)
                    }
                }
            }
            Button(action: {
                // Sign in button
            }, label: {
                Text("Sign In")
            })
            .buttonStyle(.mainButton(purpleButton, stroke: .purple700, shadow: .purple400))
            
            HStack {
                HStack {
                    Toggle("Remember", systemImage: acceptConditions ? "checkmark.square.fill" : "square", isOn: $acceptConditions)
                        .toggleStyle(.button)
                        .labelStyle(.iconOnly)
                        .font(.title3)
                        .tint(.purple700)
                    Text("Remember me")
                }
                Spacer()
                HStack {
                    NavigationLink {
//                        RecoverPasswordView()
                        Text("Recover password")
                            .environmentObject(viewModel)
                            .navigationBarBackButtonHidden()
                            
                    } label: {
                        Text("Forgot your password?")
                            .foregroundStyle(.purple700)
                    }
                }
            }
            .font(.system(size: 14, weight: .semibold, design: .rounded))
            
            FormDivider()
            
            Spacer()
            VStack(alignment: .center) {
                NavigationLink {
                    Text("Sign up view")
                        .navigationBarBackButtonHidden()
                        .environmentObject(viewModel)
                } label: {
                    HStack(alignment: .center) {
                        Text("Don't you have an account? ")
                            .foregroundStyle(.black)
                        +
                        Text("Sign up.")
                            .foregroundStyle(.purple700)
                    }
                    .font(.callout)
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
