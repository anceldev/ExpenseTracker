//
//  TransactionsView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct TransactionsView: View {
    
//    var viewModel = TransactionsViewModel()
    @State private var viewModel = TransactionsViewModel()
    @State private var categoriesViewModel = CategoriesViewModel()
    
    @State var showAddForm = false
    @State private var filterList: Transaction.Kind? = nil
    @State var selectedCategory: Transaction.Category? = nil
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                NavigationLink {

                    AddTransaction()
                        .environment(viewModel)
                } label: {
                    PlusButton()
                }
                .position(x: CGFloat(geo.size.width  - 60.0), y: CGFloat(geo.size.height - 60.0))
            }
            .zIndex(100)
            VStack(spacing: 20) {
                CardView(balance: 800, income: 950, expense: 150)
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
