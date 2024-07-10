//
//  SubscriptionsView.swift
//  ETracker
//
//  Created by Ancel Dev account on 2/7/24.
//

import SwiftUI

struct SubscriptionsView: View {
    
    @Environment(SubscriptionsViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("Subscriptions View")

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        SubscriptionsView()
            .environment(SubscriptionsViewModel())
    }
}
