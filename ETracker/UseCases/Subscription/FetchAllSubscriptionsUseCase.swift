//
//  FetchAllSubscriptionsUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import Foundation

protocol FetchAllSubscriptionsProtocol {
    func fetchAll() throws -> [ETSubscription]
}

struct FetchAllSubscriptionsUseCase: FetchAllSubscriptionsProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func fetchAll() throws -> [ETSubscription] {
        try database.fetchAllSubscriptions()
    }
}

