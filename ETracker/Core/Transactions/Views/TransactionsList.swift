//
//  TransactionsList.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

struct TransactionsList: View {
    var viewModel: TransactionsViewModel
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: 9, content: {
                ForEach(viewModel.transactions) { transaction in
                    TransactionCell(concept: transaction.concept, amount: transaction.amount, categoryName: transaction.category.name, icon: transaction.category.icon.rawValue, action: {})
                        .padding(.horizontal, 19)
                }
            })
            .padding(.vertical, 19)
        })
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .background(.red.opacity(0.2))
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        //        .overlay {
        //            RoundedRectangle(cornerRadius: 24)
        //                .stroke(.white, lineWidth: 1)
        //                .shadow(color: .gray300, radius: 0, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
        //        }
    }
}

#Preview {
    TransactionsList(viewModel: TransactionsViewModel())
        .padding()
}
