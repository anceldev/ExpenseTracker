//
//  RoundedIcon.swift
//  ETracker
//
//  Created by Ancel Dev account on 28/6/24.
//

import SwiftUI

struct RoundedIcon: View {
    let iconName: String
    let strokeColor: Color
    let selected: Bool
    
    init(iconName: String, strokeColor: Color = .gray300, selected: Bool = false) {
        self.iconName = iconName
        self.strokeColor = strokeColor
        self.selected = selected
    }
    var body: some View {
        VStack {
            Image(iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundStyle(selected ? .white : .gray1K)
        }
        .frame(width: 40, height: 40)
        .background(selected ? .purple400 : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(strokeColor, lineWidth: 1)
        }
    }
}

#Preview {
    VStack {
        RoundedIcon(iconName: "gas")
        RoundedIcon(iconName: "gas", selected: true)
    }
}
