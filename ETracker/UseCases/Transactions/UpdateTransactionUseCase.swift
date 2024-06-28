//
//  UpdateTransactionUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation

protocol UpdateTransactionProtocol {
    func updateTransaction(id: UUID, concept: String, amount: Double, transactionKind: Transaction.Kind, category: Transaction.Category, timestamp: Date, receipt: Data?) throws
}

struct UpdateTransactionUseCase: UpdateTransactionProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func updateTransaction(id: UUID, concept: String, amount: Double, transactionKind: Transaction.Kind, category: Transaction.Category, timestamp: Date, receipt: Data?) throws {
        try database.updateTransaction(
            id: id, 
            concept: concept,
            amount: amount, 
            transactionKind: transactionKind,
            category: category,
            timestamp: timestamp,
            receipt: receipt
        )
    }
}
