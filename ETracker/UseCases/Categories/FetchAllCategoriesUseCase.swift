//
//  FetchAllCategoriesUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import Foundation

protocol FetchAllCategoriesProtocol {
    func fetchAll() throws -> [TransactionCategory]
}

struct FetchAllCategoriesUseCase: FetchAllCategoriesProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func fetchAll() throws -> [TransactionCategory] {
        try database.fetchAllCategories()
    }
}
