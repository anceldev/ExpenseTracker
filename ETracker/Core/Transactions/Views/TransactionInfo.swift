//
//  TransactionInfo.swift
//  ETracker
//
//  Created by Ancel Dev account on 1/7/24.
//

import SwiftUI

struct TransactionInfo: View {
    
//    @Environment(TransactionsViewModel.self) var viewModel
    @Environment(\.dismiss) private var dismiss
    
    let id: UUID
    let concept: String
    let amount: Double
    let transactionKind: Transaction.Kind
    var categoryName: String
    let receipt: Image?
    let date: Date
    
    @State private var segments: Int = 6
    @State private var showConfirmationDialog = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: purpleButton, startPoint: .top, endPoint: .bottom)
                
                VStack {
                    Spacer()
                    Color.white
                        .frame(height: 227)
                }
                VStack(spacing: 16) {
                    Text("Amount")
                        .font(.system(size: 19, design: .rounded))
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.top, 30)
                    if let formattedQuant = NumberFormatter.moneyFormatter.string(from: NSNumber(value: amount)) {
                        HStack {
                            Text(transactionKind == .income ? "+" : "-")
                            Text(formattedQuant)
                        }
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                    }
                    VStack {
                        Text(concept)
                            .foregroundStyle(.white)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Text(categoryName)
                            .font(.system(size: 16, design: .rounded))
                            .foregroundStyle(.white.opacity(0.77))
                    }
                    .frame(height: 42)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 38)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    NavigationLink(destination: {
                        ReceiptView(image: receipt)
                    }, label: {
                        Text("Show receipt")
                    })
                    .frame(height: 42)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 38)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    Spacer()
                }
                VStack {
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(.gray600, style: StrokeStyle(lineWidth: 2, dash: [7, 7]))
                }
                .padding(12)
                
            }
            .background(
                LinearGradient(colors: purpleButton, startPoint: .top, endPoint: .bottom)
                    .shadow(.inner(color: .purple400, radius: 5, x: 0, y: -3))
            )
            .frame(maxWidth: .infinity)
            .frame(height: 494)
            .clipShape(
                RoundedRectangle(cornerRadius: 34)
            )
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        VStack {
            Spacer()
            TransactionInfo(
                id: UUID(),
                concept: "Entrepinares",
                amount: 1245.46,
                transactionKind: .income,
                categoryName: "Salary",
                receipt: Image("testreceipt"),
                date: .now
            )
        }
        .background(.yellow)
    }
}
