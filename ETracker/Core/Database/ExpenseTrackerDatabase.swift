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
    func updateTransaction(id: UUID, concept: String, amount: Double, transactionKind: Transaction.Kind, category: TransactionCategory, timestamp: Date, receipt: Data?) throws
    func removeTransaction(id: UUID) throws
    
    func insertCategory(newCategory: TransactionCategory) throws
    func fetchAllCategories() throws -> [TransactionCategory]
    func updateCategory(id: UUID, name: String, icon: TransactionCategory.Icon, hexColor: String) throws
    func removeCategory(id: UUID) throws
    
    func insertSubscription(newSubscription: ETSubscription) throws
    func fetchAllSubscriptions() throws -> [ETSubscription]
    func updateSubscription(id: UUID, service: String, amount: Double, billing: ETSubscription.Billing, chargeDate: Date?, active: Bool, notification: SubNotification?, serviceLogo: Data?) throws
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
            let schema = Schema([Transaction.self, TransactionCategory.self, ETSubscription.self, SubNotification.self])
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
            cont.mainContext.insert(TransactionCategory(name: "Groceries", icon: .groceries, hexColor: "#555555"))
            cont.mainContext.insert(TransactionCategory(name: "Gas", icon: .fuel, hexColor: "#000000"))
            cont.mainContext.insert(TransactionCategory(name: "Salary", icon: .dollar, hexColor: "#676767"))
            cont.mainContext.insert(TransactionCategory(name: "Home", icon: .house, hexColor: "#676767"))
            cont.mainContext.insert(TransactionCategory(name: "Health", icon: .doctor, hexColor: "#676767"))
            cont.mainContext.insert(TransactionCategory(name: "Hobbies", icon: .hobbies, hexColor: "#676767"))
            cont.mainContext.insert(TransactionCategory(name: "Clothing", icon: .clothing, hexColor: "#676767"))
            cont.mainContext.insert(TransactionCategory(name: "Gym", icon: .gym, hexColor: "#676767"))
            cont.mainContext.insert(TransactionCategory(name: "Holidays", icon: .holidays, hexColor: "#676767"))
            
            
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
    func updateTransaction(id: UUID, concept: String, amount: Double, transactionKind: Transaction.Kind, category: TransactionCategory, timestamp: Date, receipt: Data?) throws {
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
    @MainActor
    func removeTransaction(id: UUID) throws {
        let transactionPredicate = #Predicate<Transaction> { $0.id == id }
        var fetchDescriptor = FetchDescriptor<Transaction>(predicate: transactionPredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteTransaction = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorFetch
            }
            container.mainContext.delete(deleteTransaction)
        } catch {
            print("DEBUG - Error: Can't delete transaction \(error.localizedDescription)")
            throw DatabaseError.errorRemove
        }
    }
    
    @MainActor
    func insertCategory(newCategory: TransactionCategory) throws {
        do {
            container.mainContext.insert(newCategory)
            try container.mainContext.save()
        } catch {
            print("DEBUG - Error: Can't add new category \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }
    
    @MainActor
    func fetchAllCategories() throws -> [TransactionCategory] {
        let fetchDescriptor = FetchDescriptor<TransactionCategory>(sortBy: [SortDescriptor<TransactionCategory>(\.name)])
        
        do {
            let categories = try container.mainContext.fetch(fetchDescriptor)
            return categories
        } catch {
            print("DEBUG - Error: Can't fetch all categories \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
    @MainActor
    func updateCategory(id: UUID, name: String, icon: TransactionCategory.Icon, hexColor: String) throws {
        let categoryPredicate = #Predicate<TransactionCategory> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<TransactionCategory>(predicate: categoryPredicate)
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
        let categoryPredicate = #Predicate<TransactionCategory> {
            $0.id == id
        }
        var fetchDescriptor = FetchDescriptor<TransactionCategory>(predicate: categoryPredicate)
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
    
    @MainActor
    func insertSubscription(newSubscription: ETSubscription) throws {
        do {
            container.mainContext.insert(newSubscription)
            try container.mainContext.save()
        } catch {
            print("DEBUG - Error: Can't add new subscription \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }
    @MainActor
    func fetchAllSubscriptions() throws -> [ETSubscription] {
        let fetchDescriptor = FetchDescriptor<ETSubscription>(sortBy: [SortDescriptor<ETSubscription>(\.service)])
        do {
            let subscriptions = try container.mainContext.fetch(fetchDescriptor)
            return subscriptions
        } catch {
            print("DEBUG - Error: Can't fetch all subscriptions \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
    @MainActor
    func updateSubscription(id: UUID, service: String, amount: Double, billing: ETSubscription.Billing, chargeDate: Date?, active: Bool, notification: SubNotification?, serviceLogo: Data?) throws {
        let subscriptionPredicate = #Predicate<ETSubscription> { $0.id == id }
        var fetchDescriptor = FetchDescriptor<ETSubscription>(predicate: subscriptionPredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateSubscription = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorFetch
            }
            updateSubscription.service = service
            updateSubscription.amount = amount
            updateSubscription.billing = billing
            updateSubscription.chargeDate = chargeDate
            updateSubscription.active = active
            updateSubscription.notification = notification
            updateSubscription.serviceLogo = serviceLogo
            
            try container.mainContext.save()
        } catch {
            print("DEBUG - Error: Can't update subscription \(error.localizedDescription)")
            throw DatabaseError.errorUpdate
        }
    }
    @MainActor
    func removeSubscription(id: UUID) throws {
        let subscriptionPredicate = #Predicate<ETSubscription> { $0.id == id }
        var fetchDescriptor = FetchDescriptor<ETSubscription>(predicate: subscriptionPredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteSubscription = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorFetch
            }
            container.mainContext.delete(deleteSubscription)
        } catch  {
            print("DEBUG - Error: Can't remove subscription \(error.localizedDescription)")
            throw DatabaseError.errorRemove
        }
    }
}
