//
//  FetchAllCategoriesUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import Foundation

protocol FetchAllCategoriesProtocol {
    func fetchAll() throws -> [Transaction.Category]
}

struct FetchAllCategoriesUseCase: FetchAllCategoriesProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func fetchAll() throws -> [Transaction.Category] {
        try database.fetchAllCategories()
    }
}
