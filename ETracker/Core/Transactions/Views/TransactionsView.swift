//
//  TransactionsView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct TransactionsView: View {
    
    var viewModel = TransactionsViewModel()
    
    @State var showAddForm = false
    @State private var filterList: Transaction.Kind? = nil
    var body: some View {
        ZStack {
            GeometryReader { geo in
                NavigationLink {
                    AddTransaction(viewModel: viewModel)
                } label: {
                    PlusButton()
                }
                .position(x: CGFloat(geo.size.width  - 60.0), y: CGFloat(geo.size.height - 60.0))
            }
            VStack {
                CardView(balance: 800, income: 950, expense: 150)
                Spacer()
                TransactionsList()
            }
            .padding()
        }
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
