//
//  UpdateSubscriptionUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import Foundation

protocol UpdateSubscriptionProtocol {
    func updateSubscription(id: UUID, service: String, amount: Double, billing: ETSubscription.Billing, chargeDate: Date?, active: Bool, notification: SubNotification?, serviceLogo: Data?) throws
}

struct UpdateSubscriptionUseCase: UpdateSubscriptionProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func updateSubscription(id: UUID, service: String, amount: Double, billing: ETSubscription.Billing, chargeDate: Date?, active: Bool, notification: SubNotification?, serviceLogo: Data?) throws {
        
        try database.updateSubscription(
            id: id,
            service: service,
            amount: amount,
            billing: billing,
            chargeDate: chargeDate,
            active: active,
            notification: notification,
            serviceLogo: serviceLogo
        )
    }
}
