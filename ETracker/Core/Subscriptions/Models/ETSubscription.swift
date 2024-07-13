//
//  ETSubscription.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftData

@Model
final public class ETSubscription: Identifiable {
    @Attribute(.unique) public let id: UUID
    var service: String
    var amount: Double
    var billing: Billing
    var chargeDate: Date?
    var active: Bool
    var notification: SubNotification?
    @Attribute(.externalStorage) var serviceLogo: Data?
    
    init(
        id: UUID = UUID(),
        service: String,
        amount: Double,
        billing: Billing = .monthly,
        chargeDate: Date? = nil,
        active: Bool = false,
        notification: SubNotification? = nil,
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

extension ETSubscription {
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
