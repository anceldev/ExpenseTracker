//
//  CloseButton.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

struct CloseButton: View {

    var body: some View {
        VStack {
            Image("crosssmall")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white)
                .frame(height: 23)
        }
        .frame(width: 35, height: 35, alignment: .center)
        .background(.gray700)
        .clipShape(Circle())
    }
}

#Preview {
    CloseButton()
}
