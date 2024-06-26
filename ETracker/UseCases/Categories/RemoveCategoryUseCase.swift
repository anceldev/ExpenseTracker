//
//  RemoveCategoryUseCase.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import Foundation

protocol RemoveCategoryProtocol {
    func removeCategory(id: UUID) throws
}

struct RemoveCategoryUseCase: RemoveCategoryProtocol {
    var database: ExpenseTrackerDatabaseProtocol
    
    init(database: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase.shared) {
        self.database = database
    }
    
    func removeCategory(id: UUID) throws {
        try database.removeCategory(id: id)
    }
}
