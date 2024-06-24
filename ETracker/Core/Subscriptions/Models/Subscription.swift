//
//  Subscription.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftData

@Model
final public class Subscription: Identifiable {
    @Attribute(.unique) public let id: UUID
    let service: String
    let amount: Double
    let billing: Billing
    let chargeDate: Date?
    let active: Bool
    let notification: Subscription.Notification?
    @Attribute(.externalStorage) let serviceLogo: Data?
    
    init(
        id: UUID = UUID(),
        service: String,
        amount: Double,
        billing: Billing = .monthly,
        chargeDate: Date? = nil,
        active: Bool = false,
        notification: Subscription.Notification? = nil,
        serviceLogo: Data? = nil
    ) {
        self.id = id
        self.service = service
        self.amount = amount
        self.billing = billing
        self.chargeDate = chargeDate
        self.active = active
        self.notification = notification
        self.serviceLogo = serviceLogo
    }
    
    init() {
        self.id = UUID()
        self.service = ""
        self.amount = 0.0
        self.billing = .monthly
        self.chargeDate = nil
        self.active = false
        self.notification = nil
        self.serviceLogo = nil
    }
}

extension Subscription {
    enum Billing: String, Codable, Identifiable, CaseIterable {
        case weekly = "Weekly"
        case monthly = "Monthly"
        case quarterly = "Quarterly"
        case biannual = "Biannual"
        case annually = "Annually"
        
        var id: String {
            self.rawValue
        }
    }
}
