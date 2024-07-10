//
//  TanItemModifier.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftUI

struct TabItemModifier: ViewModifier {
    let icon: String
    
    func body(content: Content) -> some View {
        content
            .tabItem {
                Label("", systemImage: icon)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.white, for: .tabBar)
    }
}
extension View {
    func tabItemModifier(_ icon: String) -> some View {
        modifier(TabItemModifier(icon: icon))
    }
}
