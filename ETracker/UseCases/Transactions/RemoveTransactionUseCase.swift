//
//  RemoveTransactionUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation

protocol RemoveTransactionProtocol {
    func removeTransaction(id: UUID) throws
}

struct RemoveTransactionUseCase: RemoveTransactionProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    func removeTransaction(id: UUID) throws {
        try database.removeTransaction(id: id)
    }
}
