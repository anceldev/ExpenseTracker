//
//  TransactionsView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct TransactionsView: View {
    
//    var viewModel = TransactionsViewModel()
//    @State private var viewModel = TransactionsViewModel()
    @Environment(TransactionsViewModel.self) var viewModel
    @State private var categoriesViewModel = CategoriesViewModel()
    
    @State var showAddForm = false
    @State private var filterList: Transaction.Kind? = nil
    @State var selectedCategory: TransactionCategory? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                CardView(income: viewModel.totalIncomes, expense: viewModel.totalExpenses)
                CategoriesRow(selected: $selectedCategory)
                    .environment(categoriesViewModel)
                TransactionsList(selectedCategory: selectedCategory)
                    .environment(viewModel)
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
    }
}
