//
//  TransactionsViewModel.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation
import Observation
import SwiftUI

protocol TransactionsViewModelProtocol {
    var transactions: [Transaction] { get set }
    var databaseError: DatabaseError? { get set }
}

@Observable
public class TransactionsViewModel: TransactionsViewModelProtocol {
    
    var transactions: [Transaction]
    var databaseError: DatabaseError?
    
    var balance: Double {
        self.totalIncomes - self.totalExpenses
    }
    var totalIncomes: Double {
        getTotal(for: .income)
    }
    var totalExpenses: Double {
        getTotal(for: .expense)
    }
    
    private var createTransactionUseCase: CreateTransactionProtocol
    private var fetchAllTransactionsUseCase: FetchAllTransactionsProtocol
    private var updateTransactionUseCase: UpdateTransactionProtocol
    private var removeTransactionUseCase: RemoveTransactionProtocol
    
    init(
        transactions: [Transaction] = [],
        createTransactionUseCase: CreateTransactionProtocol = CreateTransactionUseCase(),
        fetchAllTransactionsUseCase: FetchAllTransactionsProtocol = FetchAllTransactionsUseCase(),
        updateTransactionUseCase: UpdateTransactionProtocol = UpdateTransactionUseCase(),
        removeTransactionUseCase: RemoveTransactionProtocol = RemoveTransactionUseCase()
    ) {
        self.transactions = transactions
        self.createTransactionUseCase = createTransactionUseCase
        self.fetchAllTransactionsUseCase = fetchAllTransactionsUseCase
        self.updateTransactionUseCase = updateTransactionUseCase
        self.removeTransactionUseCase = removeTransactionUseCase
        fetchTransactions()
    }

    func createTransaction(concept: String, amount: Double, transactionKind: Transaction.Kind, category: TransactionCategory, timestamp: Date, receipt: UIImage?) -> Bool {
        do {
            let receiptData: Data? = receipt?.jpegData(compressionQuality: 0.2) ?? nil
            try createTransactionUseCase.createTransaction(concept: concept, amount: amount, transactionKind: transactionKind, category: category, timestamp: timestamp, receipt: receiptData)
            fetchTransactions()
            return true
        } catch {
            print("DEBUG - Error: Can't create transaction: \(error.localizedDescription)")
            return false
        }
    }
    
    func updateTransaction(id: UUID, concept: String, amount: Double, transactionKind: Transaction.Kind, category: TransactionCategory, timestamp: Date, receipt: Data?) {
        do {
            try updateTransactionUseCase.updateTransaction(
                id: id,
                concept: concept,
                amount: amount,
                transactionKind: transactionKind,
                category: category,
                timestamp: timestamp,
                receipt: receipt
            )
            fetchTransactions()
        } catch {
            print("DEBUG - Error: Error updating transaction \(error.localizedDescription)")
        }
    }
    
    func removeTransaction(id: UUID) {
        do {
            try removeTransactionUseCase.removeTransaction(id: id)
            fetchTransactions()
        } catch let error as DatabaseError {
            print("DEBUG - Error: Database error \(error.localizedDescription)")
            databaseError = error
        } catch {
            print("DEBUG - Error: Use case error: \(error.localizedDescription)")
        }
    }
    func filterByCategory(category: TransactionCategory?) -> [Transaction] {
        if category == nil {
            return self.transactions
        }
        let filteredTransactions = self.transactions.filter { $0.category.id == category?.id }
        return filteredTransactions
    }
    
    
    
    func filterByKind(for transactionKind: Transaction.Kind?) -> [Transaction] {
        if let transactionKind = transactionKind {
            let filteredTransactions = transactions.filter { transaction in
                transaction.transactionKind == transactionKind
            }
            return filteredTransactions
        } else {
            return transactions
        }
    }
    
    private func fetchTransactions() {
        do {
            self.transactions = try fetchAllTransactionsUseCase.fetchAll()
        } catch {
            print("DEBUG - Error: Can't fetch transactions \(error.localizedDescription)")
        }
    }
    private func getTotal(for transactionKind: Transaction.Kind) -> Double {
        var total: Double = 0.0
        for transaction in transactions {
            if transaction.transactionKind == transactionKind {
                total += transaction.amount
            }
        }
        return total
    }
    func getReceipt(imageData: Data?) -> Image? {
        guard let data = imageData else { return nil}
        guard let uiImage = UIImage(data: data) else { return nil}
        let image = Image(uiImage: uiImage)
        return image
    }
}
