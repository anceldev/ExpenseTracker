//
//  AuthenticationView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        switch viewModel.flow {
        case .login:
            SignInView()
                .environmentObject(viewModel)
        case .signUp:
            SignUpView()
                .environmentObject(viewModel)
        case .recovery:
            RestorePasswordView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthenticationViewModel())
}
