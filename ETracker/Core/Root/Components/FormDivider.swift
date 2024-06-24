//
//  FormDivider.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct FormDivider: View {
    var body: some View {
        HStack(spacing: 20) {
            Rectangle()
                .frame(height: 1)
            Text("Or with")
                .font(.subheadline)
            Rectangle()
                .frame(height: 1)
        }
        .padding(16)
    }
}

#Preview {
    FormDivider()
}
