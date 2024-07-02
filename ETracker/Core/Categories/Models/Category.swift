//
//  Category.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftData
import SwiftUI


@Model
class TransactionCategory: Identifiable {
    @Attribute(.unique) let id: UUID
    @Attribute(.unique) var name: String
    var icon: TransactionCategory.Icon
    var hexColor: String
    
    var color: Color {
        get {
            Color(hex: self.hexColor)
        }
    }
    
    init(
        id: UUID = UUID(),
        name: String = "",
        icon: TransactionCategory.Icon,
        hexColor: String = "#000000"
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.hexColor = hexColor
    }
}

