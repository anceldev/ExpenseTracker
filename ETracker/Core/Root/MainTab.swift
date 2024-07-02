//
//  MainTab.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct MainTab<Content: View>: View where Content: View {
    
    @ViewBuilder var navigationBar: () -> Content
    @State private var viewModel = TransactionsViewModel()
    @State var selectedTab: Tab = .home
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.navigationBar = content
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
//        VStack {
//            navigationBar()
//            TabView {
//                TransactionsView()
//                    .environment(viewModel)
//                    .tabItemModifier("house")
//                AddTransaction()
//                    .environment(viewModel)
//                    .tabItemModifier("plus")
//            }
//        }
        VStack {
            VStack(spacing: 0) {
                switch selectedTab {
                case .home:
                    TransactionsView()
                        .environment(viewModel)
                case .subscriptions:
                    SubscriptionsView()
                case .analytics:
                    AnalyticsView()
                case .settings:
                    SettingsView()
                }
            }
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        MainTab {
            ProfileBar()
        }
        .environmentObject(AuthenticationViewModel())
    }
}
