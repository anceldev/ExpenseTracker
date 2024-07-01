//
//  TransactionsList.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

struct TransactionsList: View {
    
    @Environment(TransactionsViewModel.self) var viewModel
    var selectedCategory: Transaction.Category?
    @State var selectedTransaction: Transaction?
    @State var showShortInfo: Bool = true
    
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: 9, content: {
                ForEach(viewModel.filterByCategory(category: selectedCategory)) { transaction in
                    TransactionCell(
                        concept: transaction.concept,
                        amount: transaction.amount,
                        categoryName: transaction.category.name,
                        icon: transaction.category.icon.rawValue,
                        transactionKind: transaction.transactionKind,
                        action: {}
                    )
                    .padding(.horizontal, 19)
                    .onTapGesture {
                        self.selectedTransaction = transaction
                        self.showShortInfo = true
                    }
                    .sheet(item: $selectedTransaction) { transaction in
                        TransactionInfo(
                            concept: transaction.concept,
                            amount: transaction.amount,
                            transactionKind: transaction.transactionKind,
                            categoryName: transaction.category.name,
                            receipt: Image("receipt"),
                            date: transaction.timestamp)
                        .presentationDetents([.height(493)])
                        .presentationBackground(.clear)
                    }
                }
            })
            .padding(.vertical, 19)
        })
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {

    return NavigationStack {
        TransactionsList(selectedCategory: nil)
            .environment(TransactionsViewModel())
            .padding()
    }
}
