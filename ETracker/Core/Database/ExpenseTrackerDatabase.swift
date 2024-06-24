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
    func updateTransaction(id: UUID, concept: String, amount: Double, transferKind: Transaction.Kind, category: Transaction.Category, timestamp: Date?, receipt: Data?) throws
    func removeTransaction(id: UUID) throws
    
    func insertCategory(newCategory: Transaction.Category) throws
    func fetchAllCategories() throws -> [Transaction.Category]
    func updateCategory(id: UUID, name: String, icon: Transaction.Category.Icon, hexColor: String) throws
    func removeCategory(id: UUID) throws
    
    func insertSubscription(newSubscription: Subscription) throws
    func fetchAllSubscriptions() throws -> [Subscription]
    func updateSubscription(id: UUID, service: String, amount: Double, billing: Subscription.Billing, chargeDate: Date?, active: Bool, serviceLogo: Data?, notification: Subscription.Notification) throws
    func removeSubscription(id: UUID) throws
}

final class ExpenseTrackerDatabase: ExpenseTrackerDatabaseProtocol {
    
    static let shared: ExpenseTrackerDatabase = ExpenseTrackerDatabase()
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    @MainActor
    static private func setupContainer(inMemory: Bool) -> ModelContainer {
        @AppStorage("sampleDataAdded") var sampleDataAdded: Bool = false
        
        do {
            let schema = Schema([Transaction.self, Transaction.Category.self, Subscription.self, Subscription.Notification.self])
            let config = ModelConfiguration(isStoredInMemoryOnly: inMemory, allowsSave: true)
            let container = try ModelContainer(for: schema, configurations: config)
            
//            var categoriesFetchDescriptor = FetchDescriptor<Transaction.Category>()
//            categoriesFetchDescriptor.fetchLimit = 1
//
//            guard try container.mainContext.fetch(categoriesFetchDescriptor).count == 0 else { return container }
            if sampleDataAdded { return container }
            
            // Default categories values
            print("Adding default categories...")
            container.mainContext.insert(Transaction.Category(name: "Groceries", icon: .groceries, hexColor: "#555555"))
            container.mainContext.insert(Transaction.Category(name: "Gas", icon: .gas, hexColor: "#000000"))
            container.mainContext.insert(Transaction.Category(name: "Salary", icon: .cheapdollar, hexColor: "#676767"))
            container.mainContext.insert(Transaction.Category(name: "Home", icon: .house, hexColor: "#676767"))
            container.mainContext.insert(Transaction.Category(name: "Health", icon: .doctor, hexColor: "#676767"))
            container.mainContext.insert(Transaction.Category(name: "Hobbies", icon: .hobbies, hexColor: "#676767"))
            container.mainContext.insert(Transaction.Category(name: "Clothing purchases", icon: .clothes, hexColor: "#676767"))
            container.mainContext.insert(Transaction.Category(name: "Gym membership", icon: .gym, hexColor: "#676767"))
            container.mainContext.insert(Transaction.Category(name: "Holidays", icon: .holidays, hexColor: "#676767"))
            
            print("Adding default subscriptions...")
            let calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.year = 2024
            dateComponents.month = 6
            dateComponents.day = 28
            
            let spotifyLogoData = UIImage(named: "spotify")?.pngData()
            let spotifyDate: Date? = calendar.date(from: dateComponents)
            container.mainContext.insert(Subscription(service: "Spotify", amount: 5.00,chargeDate: spotifyDate, active: false, serviceLogo: spotifyLogoData))
            
            print("Saving default data...")
            try container.mainContext.save()
            sampleDataAdded = true
            print("Database created successfully")
            return container
                        
        } catch {
            print("Error: \(error.localizedDescription)")
            fatalError("Database cannot be created")
        }
    }
    
    func insertTransaction(newTransaction: Transaction) throws {
        //
    }
    
    func fetchAllTransactions() throws -> [Transaction] {
        []
    }
    
    func updateTransaction(id: UUID, concept: String, amount: Double, transferKind: Transaction.Kind, category: Transaction.Category, timestamp: Date?, receipt: Data?) throws {
        
    }
    
    func removeTransaction(id: UUID) throws {
        
    }
    
    func insertCategory(newCategory: Transaction.Category) throws {
        
    }
    
    func fetchAllCategories() throws -> [Transaction.Category] {
        []
    }
    
    func updateCategory(id: UUID, name: String, icon: Transaction.Category.Icon, hexColor: String) throws {
        
    }
    
    func removeCategory(id: UUID) throws {
        
    }
    
    func insertSubscription(newSubscription: Subscription) throws {
        
    }
    
    func fetchAllSubscriptions() throws -> [Subscription] {
        []
    }
    
    func updateSubscription(id: UUID, service: String, amount: Double, billing: Subscription.Billing, chargeDate: Date?, active: Bool, serviceLogo: Data?, notification: Subscription.Notification) throws {
        
    }
    
    func removeSubscription(id: UUID) throws {
        
    }
}
