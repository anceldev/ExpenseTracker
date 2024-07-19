//
//  CustomInputField.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct CustomInputFieldModifier: ViewModifier {
    
    let width: CGFloat
    
    func body(content: Content) -> some View {
        content
//            .frame(height: 58)
            .frame(height: 51)
            .frame(maxWidth: width, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 13))
            .overlay {
                RoundedRectangle(cornerRadius: 13)
                    .stroke(.gray400.opacity(0.6), lineWidth: 2)
            }
    }
}

extension View {
    func customInputField(_ width: CGFloat) -> some View {
        modifier(CustomInputFieldModifier(width: width))
    }
}

#Preview {
    TextField("Text", text: .constant("Enter text"))
        .customInputField(.infinity)
}
