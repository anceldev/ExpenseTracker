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
            .frame(height: 58)
            .frame(maxWidth: width, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray300, lineWidth: 1)
            }
    }
}

extension View {
    func customInputField(_ width: CGFloat) -> some View {
        modifier(CustomInputFieldModifier(width: width))
    }
}
