//
//  RoundedButton.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import SwiftUI

struct RoundedButton: View {
    
    let iconName: String
    let selected: Bool
    let buttonName: String
    
    var body: some View {
        VStack {
            VStack {
                RoundedIcon(
                    iconName: iconName,
                    selected: selected
                )
            }
            Text(buttonName)
                .font(.system(size: 10  , weight: .semibold, design: .rounded))
                .foregroundStyle(selected ? .black : .gray1K)
        }
    }
}

#Preview {
    RoundedButton(iconName: "camera", selected: true, buttonName: "Salary")
}
