//
//  CardView.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct CardView: View {
    
    let income: Double 
    let expense: Double
    
    var balance: Double {
        income - expense
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: pinkCard, startPoint: .bottom, endPoint: .top)
            VStack(alignment: .leading, spacing: 10) {
                Text("Total Balance")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                if let formattedQuant = NumberFormatter.moneyFormatter.string(from: NSNumber(value: balance)) {
                    Text(formattedQuant)
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                }
                Spacer()
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "arrow.down")
                            Text("Income")
                                .font(.system(size: 16, weight: .regular))
                        }
                        if let formattedQuant = NumberFormatter.moneyFormatter.string(from: NSNumber(value: income)) {
                            Text(formattedQuant)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                        }
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "arrow.down")
                            Text("Expense")
                                .font(.system(size: 16, weight: .regular))
                        }
                        if let formattedQuant = NumberFormatter.moneyFormatter.string(from: NSNumber(value: expense)) {
                            Text(formattedQuant)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(30)
            
        }
        .foregroundStyle(.white)
//        .frame(width: 362, height: 223)
        .frame(width: 362, height: 183)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    CardView(income: 1450.0, expense: 150.00)
}
