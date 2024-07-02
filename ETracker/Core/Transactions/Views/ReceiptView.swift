//
//  ReceiptView.swift
//  ETracker
//
//  Created by Ancel Dev account on 1/7/24.
//

import SwiftUI

struct ReceiptView: View {
    let image: Image?
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 16) {
                Text("Receipt")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                if let image = image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text("No receipt added to transaction")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.orange)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            .padding(.horizontal, 16)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    ReceiptView(image: Image("testreceipt"))
})
#Preview(traits: .sizeThatFitsLayout, body: {
    ReceiptView(image: nil)
})

