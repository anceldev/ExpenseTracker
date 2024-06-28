//
//  CategoriesViewModel.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import Foundation
import Observation

protocol CategoriesViewModelProtocol {
    var categories: [Transaction.Category] { get set }
    var databaseError: DatabaseError? { get set }
}


@Observable
public class CategoriesViewModel: CategoriesViewModelProtocol {
    var categories: [Transaction.Category]
    var databaseError: DatabaseError?
    
    private var createCategoryUseCase: CreateCategoryProtocol
    private var fetchCategoriesUseCase: FetchAllCategoriesProtocol
    private var updateCategoryUseCase: UpdateCategoryProtocol
    private var removeCategoryUseCase: RemoveCategoryProtocol
    
    init(
        categories: [Transaction.Category] = [],
        createCategoryUseCase: CreateCategoryProtocol = CreateCategoryUseCase(),
        fetchCategoriesUseCase: FetchAllCategoriesProtocol = FetchAllCategoriesUseCase(),
        updateCategoryUseCase: UpdateCategoryProtocol = UpdateCategoryUseCase(),
        removeCategoryUseCase: RemoveCategoryProtocol = RemoveCategoryUseCase()
    ) {
        self.categories = categories
        self.createCategoryUseCase = createCategoryUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        self.updateCategoryUseCase = updateCategoryUseCase
        self.removeCategoryUseCase = removeCategoryUseCase
        fetchAllCategories()
    }
    
    func createCategory(name: String, icon: Transaction.Category.Icon, hexColor: String) {
        do {
            try createCategoryUseCase.createCategory(name: name, icon: icon, hexColor: hexColor)
            fetchAllCategories()
        } catch {
            print("DEBUG - Error: Error creating category with use case \(error.localizedDescription)")
        }
    }
    func updateCategory(id: UUID, name: String, icon: Transaction.Category.Icon, hexColor: String) {
        do {
            try updateCategoryUseCase.updateCategory(id: id, name: name, icon: icon, hexcolor: hexColor)
            fetchAllCategories()
        } catch {
            print("DEBUG - Error: Error updating category with use case \(error.localizedDescription)")
        }
    }
    func removeCategory(id: UUID) {
        do {
            try removeCategoryUseCase.removeCategory(id: id)
            fetchAllCategories()
        } catch {
            print("DEBUG - Error: Error removing category with use case \(error.localizedDescription)")
        }
    }
    
    
    private func fetchAllCategories() {
        do {
            self.categories = try fetchCategoriesUseCase.fetchAll()
        } catch {
            print("DEBUG - Error: Error fetching categories with use case \(error.localizedDescription)")
        }
    }
}
