//
//  TransactionCell.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct TransactionCell: View {
    let concept: String
    let amount: Double
    let categoryName: String
    let icon: String
    let action: () -> Void
    var body: some View {
        HStack(spacing: 14) {
            VStack {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
            }
            .frame(width: 40, height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray300, lineWidth: 1)
            }
            
            VStack(alignment: .leading) {
                Text(categoryName)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.gray900)
                Text(concept)
                    .font(.system(size: 15, weight: .semibold))
            }
            .padding(.leading, 11)
            Spacer()
            Button(action: action, label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundStyle(.gray1K3)
            })
        }
        .padding(.horizontal, 14)
        .frame(maxWidth: .infinity)
        .frame(height: 68)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(.gray300, lineWidth: 1)
        }
    }
}
#Preview {
    TransactionsList(viewModel: TransactionsViewModel())
        .padding()
}
//
//#Preview {
//    VStack {
//        TransactionCell(concept: "Mazda 13", amount: 54.98, categoryName: "Gas", icon: "gas"){
//            print("Tapped")
//        }
//    }
//    .padding()
//    .background(.red.opacity(0.3))
//        
//}
