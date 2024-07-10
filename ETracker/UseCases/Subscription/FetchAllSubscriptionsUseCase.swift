//
//  FetchAllSubscriptionsUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import Foundation

protocol FetchAllSubscriptionsProtocol {
    func fetchAll() throws -> [Subscription]
}

struct FetchAllSubscriptionsUseCase: FetchAllSubscriptionsProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func fetchAll() throws -> [Subscription] {
        try database.fetchAllSubscriptions()
    }
}

