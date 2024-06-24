//
//  FetchAllTransactionsUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation

protocol FetchAllTransactionsProtocol {
    func fetchAll() throws -> [Transaction]
}

struct FetchAllTransactionsUseCase: FetchAllTransactionsProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func fetchAll() throws -> [Transaction] {
        try database.fetchAllTransactions()
    }
}
