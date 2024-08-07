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


extension TransactionCategory {
    enum Icon: String, Codable, CaseIterable, Identifiable {
        case briefcase = "briefcase.fill"
        case dollar = "dollarsign.circle.fill"
        case clothing = "tshirt.fill"
        case doctor = "stethoscope"
        case entertaninment = "tv.inset.filled"
        case fuel = "fuelpump.fill"
        case groceries = "basket.fill"
        case gym = "dumbbell.fill"
        case hobbies = "figure.bowling"
        case house = "house.fill"
        case pets = "pawprint.fill"
        case transportation = "bus.fill"
        case trip = "airplane"
        case holidays = "beach.umbrella.fill"
        
        var id: String {
            self.rawValue
        }
    
        var icon: Image {
            Image(systemName: "self.rawValue")
        }
    }
}
