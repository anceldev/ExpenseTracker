//
//  Icon.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftData
import SwiftUI

extension TransactionCategory {
    enum Icon: String, Codable, CaseIterable, Identifiable {
        case briefcase
        case calendarclock
        case camera
        case cheapdollar
        case clothes
        case doctor
        case gas
        case groceries
        case gym
        case hobbies
        case holidays
        case house
        case moneywings
        case pets
        case rent
        
        var id: String {
            self.rawValue
        }
    
        var icon: Image {
            Image(self.rawValue)
        }
    }
}
