//
//  MainTab.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct MainTab<Content: View>: View where Content: View {
    
    @ViewBuilder var navigationBar: () -> Content
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    @State private var viewModel = TransactionsViewModel()
    @State private var subsViewModel = SubscriptionsViewModel()
    @State private var categoriesViewModel = CategoriesViewModel()

    @State var selectedTab: Tab = .home
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.navigationBar = content
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                navigationBar()
                switch selectedTab {
                case .home:
                    TransactionsView()
                        .environment(viewModel)
                case .subscriptions:
                    SubscriptionsView()
                        .environment(subsViewModel)
                case .analytics:
                    AnalyticsView()
                case .settings:
                    AccountView()
                        .environmentObject(authViewModel)
                }
                CustomTabBar(selectedTab: $selectedTab)
                    .environment(viewModel)
                    .environment(subsViewModel)
                    .environment(categoriesViewModel)
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

#Preview {
    NavigationStack {
        MainTab {
            ProfileBar()
        }
        .environmentObject(AuthenticationViewModel())
        .environment(CategoriesViewModel())
    }
}
