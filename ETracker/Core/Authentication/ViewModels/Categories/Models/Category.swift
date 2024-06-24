//
//  Category.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftData
import SwiftUI


extension Transaction {
    @Model
    class Category: Identifiable {
        @Attribute(.unique) let id: UUID
        @Attribute(.unique) let name: String
        let icon: Transaction.Category.Icon
        let hexColor: String
        
        var color: Color {
            get {
                Color(hex: self.hexColor)
            }
        }
        
        init(
            id: UUID = UUID(),
            name: String = "",
            icon: Transaction.Category.Icon,
            hexColor: String = "#000000"
        ) {
            self.id = id
            self.name = name
            self.icon = icon
            self.hexColor = hexColor
        }
    }
}
