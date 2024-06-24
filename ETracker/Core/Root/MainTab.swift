//
//  MainTab.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct MainTab<Content: View>: View where Content: View {
    @ViewBuilder var navigationBar: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.navigationBar = content
    }
    
    var body: some View {
        VStack {
            navigationBar()
            TabView {
                TransactionsView()
                    .tabItemModifier("house")
            }
        }
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
