//
//  CustomCapsule.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import Foundation
import SwiftUI

struct CustomCapsule: ButtonStyle {
    let color: Color
    
    init(color: Color = .iris600) {
        self.color = color
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 77, height: 36)
            .background(
//                LinearGradient(colors: purpleButton, startPoint: .bottom, endPoint: .top)
//                    .shadow(.inner(color: .purple400, radius: 1, x: 0, y: -3))
//                .iris600
                color
            )
            .clipShape(Capsule())
            .font(.system(size: 18, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
//            .overlay(
//                Capsule()
//                    .stroke(.purple700, lineWidth: 0.5)
//            )
    }
}
extension ButtonStyle where Self == CustomCapsule {
    static var customCapsule: CustomCapsule { .init() }
    static func customCapsule(color: Color) -> CustomCapsule {
        CustomCapsule(color: color)
    }
}
