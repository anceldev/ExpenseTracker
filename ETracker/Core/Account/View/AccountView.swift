//
//  AccountView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Account view")
            Spacer()
            Button(action: {
                authViewModel.signOut()
                dismiss()
            }, label: {
                Text("Sign Out")
            })
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(AuthenticationViewModel())
}
