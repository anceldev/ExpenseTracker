//
//  MoneyInput.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

struct MoneyInput<InputField: View>: View where InputField: View {
    
    let title: String
    let amount: Double
    @ViewBuilder var inputField: () -> InputField
    
    init(title: String, amount: Double, inputField: @escaping () -> InputField) {
        self.title = title
        self.amount = amount
        self.inputField = inputField
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
            HStack(spacing: 16) {
                inputField()
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .fixedSize()
                    .padding(.leading, 19)
                VerticalDivider()
                Text("$")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(amount != 0.0 ? .purple400 : .gray1K2)
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
