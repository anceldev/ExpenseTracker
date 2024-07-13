//
//  CreateSubscriptionUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import Foundation

protocol CreateSubscriptionProtocol {
    func createSubscription(service: String, amount: Double, billing: ETSubscription.Billing, chargeDate: Date?, active: Bool, notification: SubNotification?, serviceLogo: Data?) throws
}

struct CreateSubscriptionUseCase: CreateSubscriptionProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func createSubscription(service: String, amount: Double, billing: ETSubscription.Billing, chargeDate: Date?, active: Bool, notification: SubNotification?, serviceLogo: Data?) throws {
        let newSubscription = ETSubscription(
            service: service,
            amount: amount,
            billing: billing,
            chargeDate: chargeDate,
            active: active,
            notification: notification,
            serviceLogo: serviceLogo
        )
        try database.insertSubscription(newSubscription: newSubscription)
    }
}
