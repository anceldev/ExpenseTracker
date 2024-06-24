//
//  Transaction.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import SwiftData

@Model
public class Transaction: Identifiable {
    @Attribute(.unique) public let id: UUID
    let concept: String
    let amount: Double
    let transactionKind: Transaction.Kind
    let category: Transaction.Category
    let timestamp: Date
    @Attribute(.externalStorage) var receipt: Data?
    
    init(
        id: UUID = UUID(),
        concept: String = "",
        amount: Double = 0.00,
        transactionKind: Transaction.Kind = .income,
        category: Category,
        timestamp: Date? = .now,
        receipt: Data? = nil
    ) {
        self.id = id
        self.concept = concept
        self.amount = amount
        self.transactionKind = transactionKind
        self.category = category
        self.timestamp = timestamp!
        self.receipt = receipt
    }
}

extension Transaction {
    enum Kind: String, Codable {
        case income = "+"
        case expense = "-"
    }
    
}
