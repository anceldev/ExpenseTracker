//
//  PlusButton.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

struct PlusButton: View {
    var body: some View {
        Label("Add", systemImage: "plus")
            .labelStyle(.iconOnly)
            .padding()
            .background(
                LinearGradient(colors: purpleButton, startPoint: .bottom, endPoint: .top)
                    .shadow(.inner(color: .purple400, radius: 1, x: 0, y: -3))
            )
            .clipShape(Circle())
            .overlay(alignment: .center) {
                Circle().stroke(.purple700, lineWidth: 0.5)
            }
            .foregroundStyle(.white)
            .fontDesign(.rounded)
            .fontWeight(.bold)
    }
}

#Preview {
    PlusButton()
}
