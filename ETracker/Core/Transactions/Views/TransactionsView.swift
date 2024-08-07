//
//  TransactionsView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI


struct TransactionsView: View {

    @Environment(TransactionsViewModel.self) var viewModel
    @Environment(CategoriesViewModel.self) var categoriesViewModel

    @State var showAddForm = false
    @State private var filterList: Transaction.Kind? = nil
    @State var selectedCategory: TransactionCategory? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                CardView(income: viewModel.totalIncomes, expense: viewModel.totalExpenses)
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Transactions")
                            .foregroundStyle(.gray900)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    ScrollView {
                        VStack(spacing: 16) {
                            CategoriesRow(selected: $selectedCategory)
                                .environment(categoriesViewModel)
                            TransactionsList(selectedCategory: selectedCategory)
                                .environment(viewModel)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .background(.gray100)
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
