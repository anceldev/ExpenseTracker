//
//  TransactionsList.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

struct TransactionsList: View {
    
    @Environment(TransactionsViewModel.self) var viewModel
    var selectedCategory: TransactionCategory?
    @State var selectedTransaction: Transaction?
//    @State var showShortInfo: Bool = true
    
    var title: String? {
        guard let title = selectedCategory?.name else { return nil }
        return title
    }
    
    var body: some View {
        VStack{
            if let title {
                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.gray800)
            }
            ScrollView(.vertical, content: {
                VStack(spacing: 9, content: {
                    ForEach(viewModel.filterByCategory(category: selectedCategory)) { transaction in
                        TransactionCell(
                            concept: transaction.concept,
                            amount: transaction.amount,
                            categoryName: transaction.category.name,
                            icon: transaction.category.icon.rawValue,
                            transactionKind: transaction.transactionKind,
                            viewAction: {
                                self.selectedTransaction = transaction
                            },
                            deleteAction: {
                                viewModel.removeTransaction(id: transaction.id)
                            }
                        )

                        .sheet(item: $selectedTransaction) { transaction in
                            TransactionInfo(
                                id: transaction.id,
                                concept: transaction.concept,
                                amount: transaction.amount,
                                transactionKind: transaction.transactionKind,
                                categoryName: transaction.category.name,
                                receipt: viewModel.getReceipt(imageData: transaction.receipt),
                                date: transaction.timestamp
                            )
                            .presentationDetents([.height(493)])
                            .presentationBackground(.clear)
                        }
                    }
                })
            })
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.white)
    }
}

#Preview {
    NavigationStack {
        MainTab {
            ProfileBar()
        }
        .environmentObject(AuthenticationViewModel())
        .environment(CategoriesViewModel())
    }
}
