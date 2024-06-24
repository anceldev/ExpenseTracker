//
//  VerticalDivider.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct VerticalDivider: View {
    
    let color: Color
    init(color: Color = .gray) {
        self.color = color
    }
    
    var body: some View {
        VStack(alignment: .center) {
            color
        }
        .frame(width: 2.5, height: 28)
    }
}
