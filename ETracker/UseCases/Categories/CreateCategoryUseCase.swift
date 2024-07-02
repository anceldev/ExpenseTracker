//
//  CreateCategoryUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import Foundation

protocol CreateCategoryProtocol {
    func createCategory(name: String, icon: TransactionCategory.Icon, hexColor: String) throws
}

struct CreateCategoryUseCase: CreateCategoryProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func createCategory(name: String, icon: TransactionCategory.Icon, hexColor: String) throws {
        let newCategory: TransactionCategory = .init(name: name, icon: icon, hexColor: hexColor)
        try database.insertCategory(newCategory: newCategory)
    }
}
