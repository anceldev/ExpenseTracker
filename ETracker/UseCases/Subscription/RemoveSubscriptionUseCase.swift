//
//  RemoveSubscriptionUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import Foundation

protocol RemoveSubscriptionProtocol {
    func removeSubscription(id: UUID) throws
}

struct RemoveSubscriptionUseCase: RemoveSubscriptionProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func removeSubscription(id: UUID) throws {
        try database.removeSubscription(id: id)
    }
}
