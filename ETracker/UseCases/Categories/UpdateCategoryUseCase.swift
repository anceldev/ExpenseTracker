//
//  UpdateCategoryUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import Foundation

protocol UpdateCategoryProtocol {
    func updateCategory(id: UUID, name: String, icon: Transaction.Category.Icon, hexcolor: String) throws
}

struct UpdateCategoryUseCase: UpdateCategoryProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func updateCategory(id: UUID, name: String, icon: Transaction.Category.Icon, hexcolor: String) throws {
        try database.updateCategory(id: id, name: name, icon: icon, hexColor: hexcolor)
    }
}
