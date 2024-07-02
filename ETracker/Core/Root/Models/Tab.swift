//
//  Tab.swift
//  ETracker
//
//  Created by Ancel Dev account on 2/7/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case subscriptions = "Subscriptions"
    case analytics = "Analytics"
    case settings = "Settings"
    
    var icon: String {
        switch self {
        case .home:
            "house"
        case .subscriptions:
            "heart"
        case .analytics:
            "chart.pie"
        case .settings:
            "person"
        }
    }
}
