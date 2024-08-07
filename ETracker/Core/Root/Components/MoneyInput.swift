//
//  MoneyInput.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

struct MoneyInput<InputField: View>: View where InputField: View {
    
    let title: String
    var amount: Double
    @ViewBuilder var inputField: () -> InputField
    
    init(title: String, amount: Double, inputField: @escaping () -> InputField) {
        self.title = title
        self.amount = amount
        self.inputField = inputField
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.gray600)
            HStack(spacing: 16) {
                inputField()
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .fixedSize()
                    .padding(.leading, 19)
                    .keyboardType(.decimalPad)
                    .foregroundStyle(.gray700)
                VerticalDivider()
                Text("$")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(amount != 0.0 ? .iris700 : .gray1K2)
                Spacer()
            }
            .customInputField(.infinity)
        }
    }
}

#Preview {
    MoneyInput(title: "Amount", amount: 2.0) {
        TextField("", value: .constant(0.0), formatter: NumberFormatter())
    }
}
