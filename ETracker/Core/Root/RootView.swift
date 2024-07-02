//
//  RootView.swift
//  ETracker
//
//  Created by Ancel Dev account on 2/7/24.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack {
                switch selectedTab {
                case .home:
                    Text("Transactions")
                case .subscriptions:
                    Text("Subscriptions")
                case .analytics:
                    Text("Analytics")
                case .settings:
                    Text("Settings")
                }
            }
            Spacer()
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RootView()
        .background(.gray)
}
