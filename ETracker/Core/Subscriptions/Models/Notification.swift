//
//  Notification.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftData

extension Subscription {
    
    @Model
    final public class Notification: Identifiable {
        @Attribute(.unique) public var id: UUID
        let active: Bool
        let onDate: Date?
        
        init(id: UUID = UUID(), active: Bool = false, onDate: Date? = nil) {
            self.id = id
            self.active = active
            self.onDate = onDate
        }
    }
}
