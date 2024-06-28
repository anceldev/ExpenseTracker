//
//  CreateTransactionUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation

protocol CreateTransactionProtocol {
    func createTransaction(concept: String, amount: Double, transactionKind: Transaction.Kind, category: Transaction.Category, timestamp: Date, receipt: Data?) throws
}

struct CreateTransactionUseCase: CreateTransactionProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func createTransaction(concept: String, amount: Double, transactionKind: Transaction.Kind, category: Transaction.Category, timestamp: Date, receipt: Data?) throws {
        let newTransaction: Transaction = .init(
            concept: concept,
            amount: amount,
            transactionKind: transactionKind,
            category: category,
            timestamp: timestamp,
            receipt: receipt
        )
        try database.insertTransaction(newTransaction: newTransaction)
    }
    
}
