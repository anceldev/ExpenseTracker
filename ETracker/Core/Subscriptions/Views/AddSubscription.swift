//
//  AddSubscription.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import SwiftUI

struct AddSubscription: View {
    
    @Environment(SubscriptionsViewModel.self) var viewModel
    
    var body: some View {
        Text("Add Subscription")
    }
}

#Preview {
    AddSubscription()
        .environment(SubscriptionsViewModel())
}
