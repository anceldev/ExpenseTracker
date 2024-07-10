//
//  RoundedIcon.swift
//  ETracker
//
//  Created by Ancel Dev account on 28/6/24.
//

import SwiftUI

struct RoundedIcon: View {
    let iconName: String
    let selected: Bool
    
    init(iconName: String, selected: Bool = false) {
        self.iconName = iconName
        self.selected = selected
    }
    var body: some View {
        VStack {
            Image(iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundStyle(selected ? .white : .gray600)
        }
        .frame(width: 40, height: 40)
        .background(selected ? .purple400 : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(selected ? Color.purple200 : Color.gray300, lineWidth: 1)
        }
    }
}


#Preview(traits: .sizeThatFitsLayout, body: {
    RoundedIcon(iconName: "gas", selected: true)
})
