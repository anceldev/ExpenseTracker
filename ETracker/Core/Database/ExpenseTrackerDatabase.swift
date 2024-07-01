//
//  ExpenseTrackerDatabase.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftData
import SwiftUI

enum DatabaseError: Error {
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorRemove
}

protocol ExpenseTrackerDatabaseProtocol {
    func insertTransaction(newTransaction: Transaction) throws
    func fetchAllTransactions() throws -> [Transaction]
    func updateTransaction(id: UUID, concept: String, amount: Double, transactionKind: Transaction.Kind, category: Transaction.Category, timestamp: Date, receipt: Data?) throws
    func removeTransaction(id: UUID) throws
    
    func insertCategory(newCategory: Transaction.Category) throws
    func fetchAllCategories() throws -> [Transaction.Category]
    func updateCategory(id: UUID, name: String, icon: Transaction.Category.Icon, hexColor: String) throws
    func removeCategory(id: UUID) throws
    
    func insertSubscription(newSubscription: Subscription) throws
    func fetchAllSubscriptions() throws -> [Subscription]
    func updateSubscription(id: UUID, service: String, amount: Double, billing: Subscription.Billing, chargeDate: Date?, active: Bool, serviceLogo: Data?, notification: SubNotification) throws
    func removeSubscription(id: UUID) throws
}

final class ExpenseTrackerDatabase: ExpenseTrackerDatabaseProtocol {
    
    static let shared: ExpenseTrackerDatabaseProtocol = ExpenseTrackerDatabase()
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    @MainActor
    static private func setupContainer(inMemory: Bool) -> ModelContainer {
        @AppStorage("sampleDataAdded") var sampleDataAdded: Bool = false
        
        do {
            let schema = Schema([Transaction.self, Transaction.Category.self, Subscription.self, SubNotification.self])
            let config = ModelConfiguration(isStoredInMemoryOnly: inMemory, allowsSave: true)
            
            var cont: ModelContainer!
            do {
                cont = try ModelContainer(for: schema, configurations: config)
            } catch {
                print(error.localizedDescription)
            }
//            let cont = try ModelContainer(for: schema, configurations: config)
            
//            var categoriesFetchDescriptor = FetchDescriptor<Transaction.Category>()
//            categoriesFetchDescriptor.fetchLimit = 1
//
//            guard try container.mainContext.fetch(categoriesFetchDescriptor).count == 0 else { return container }
            if sampleDataAdded { return cont }
            
            // Default categories values
            print("Adding default categories...")
            cont.mainContext.insert(Transaction.Category(name: "Groceries", icon: .groceries, hexColor: "#555555"))
            cont.mainContext.insert(Transaction.Category(name: "Gas", icon: .gas, hexColor: "#000000"))
            cont.mainContext.insert(Transaction.Category(name: "Salary", icon: .cheapdollar, hexColor: "#676767"))
            cont.mainContext.insert(Transaction.Category(name: "Home", icon: .house, hexColor: "#676767"))
            cont.mainContext.insert(Transaction.Category(name: "Health", icon: .doctor, hexColor: "#676767"))
            cont.mainContext.insert(Transaction.Category(name: "Hobbies", icon: .hobbies, hexColor: "#676767"))
            cont.mainContext.insert(Transaction.Category(name: "Clothing", icon: .clothes, hexColor: "#676767"))
            cont.mainContext.insert(Transaction.Category(name: "Gym", icon: .gym, hexColor: "#676767"))
            cont.mainContext.insert(Transaction.Category(name: "Holidays", icon: .holidays, hexColor: "#676767"))
            
//            print("Adding default subscriptions...")
//            let calendar = Calendar.current
//            var dateComponents = DateComponents()
//            dateComponents.year = 2024
//            dateComponents.month = 6
//            dateComponents.day = 28
//            
//            let spotifyLogoData = UIImage(named: "spotify")?.pngData()
//            let spotifyDate: Date? = calendar.date(from: dateComponents)
//            cont.mainContext.insert(Subscription(service: "Spotify", amount: 5.00,chargeDate: spotifyDate, active: false, notification: nil , serviceLogo: spotifyLogoData))
            
            print("Saving default data...")
            try cont.mainContext.save()
            sampleDataAdded = true
            print("Database created successfully")
            return cont
                        
        } catch {
            print("Error: \(error.localizedDescription)")
            fatalError("Database cannot be created")
        }
    }
    @MainActor
    func insertTransaction(newTransaction: Transaction) throws {
        do {
            container.mainContext.insert(newTransaction)
            try container.mainContext.save()
        } catch {
            print("DEBUG - Error: Can't add new transaction \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }
    @MainActor
    func fetchAllTransactions() throws -> [Transaction] {
        let fetchDescriptor = FetchDescriptor<Transaction>(sortBy: [SortDescriptor<Transaction>(\.timestamp)])
        do {
            let transactions = try container.mainContext.fetch(fetchDescriptor)
            return transactions
        } catch {
            print("DEBUG - Error: Can't fetch all transactions \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
    @MainActor
    func updateTransaction(id: UUID, concept: String, amount: Double, transactionKind: Transaction.Kind, category: Transaction.Category, timestamp: Date, receipt: Data?) throws {
        let transactionPredicate = #Predicate<Transaction> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<Transaction>(predicate: transactionPredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateTransaction = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            updateTransaction.concept = concept
            updateTransaction.amount = amount
            updateTransaction.transactionKind = transactionKind
            updateTransaction.category = category
            updateTransaction.timestamp = timestamp
            updateTransaction.receipt = receipt
            
            try container.mainContext.save()
        } catch {
            print("DEBUG - Error: Can't update transaction \(error.localizedDescription)")
            throw DatabaseError.errorUpdate
        }
    }
    
    func removeTransaction(id: UUID) throws {
        
    }
    
    @MainActor
    func insertCategory(newCategory: Transaction.Category) throws {
        do {
            container.mainContext.insert(newCategory)
            try container.mainContext.save()
        } catch {
            print("DEBUG - Error: Can't add new category \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }
    
    @MainActor
    func fetchAllCategories() throws -> [Transaction.Category] {
        let fetchDescriptor = FetchDescriptor<Transaction.Category>(sortBy: [SortDescriptor<Transaction.Category>(\.name)])
        
        do {
            let categories = try container.mainContext.fetch(fetchDescriptor)
            return categories
        } catch {
            print("DEBUG - Error: Can't fetch all categories \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
    @MainActor
    func updateCategory(id: UUID, name: String, icon: Transaction.Category.Icon, hexColor: String) throws {
        let categoryPredicate = #Predicate<Transaction.Category> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<Transaction.Category>(predicate: categoryPredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateCategory =  try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            
            updateCategory.name = name
            updateCategory.icon = icon
            updateCategory.hexColor = hexColor
            
            try container.mainContext.save()

        } catch {
            print("DEBUG - Error: Can't update category \(error.localizedDescription)")
            throw DatabaseError.errorUpdate
        }
        
    }
    @MainActor
    func removeCategory(id: UUID) throws {
        let categoryPredicate = #Predicate<Transaction.Category> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<Transaction.Category>(predicate: categoryPredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteCategory = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorFetch
            }
            container.mainContext.delete(deleteCategory)
        } catch {
            print("DEBUG - Error: Can't delete category \(error.localizedDescription)")
            throw DatabaseError.errorRemove
        }
    }
    
    func insertSubscription(newSubscription: Subscription) throws {
        
    }
    
    func fetchAllSubscriptions() throws -> [Subscription] {
        []
    }
    
    func updateSubscription(id: UUID, service: String, amount: Double, billing: Subscription.Billing, chargeDate: Date?, active: Bool, serviceLogo: Data?, notification: SubNotification) throws {
        
    }
    
    func removeSubscription(id: UUID) throws {
        
    }
}
