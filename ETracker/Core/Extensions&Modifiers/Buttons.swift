//
//  Buttons.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

//import Foundation
import SwiftUI


enum ButtonTypeEnum {
    case submit
    case cancel
    case delete
    
    var color: Color {
        switch self {
        case .submit: return .iris600
        case .cancel: return .gray200.opacity(0.85)
        case .delete: return .redCancel
        }
    }
    var text: Color {
        switch self {
        case .cancel: return .gray700
        default: return .white
        }
    }
}

struct MainButton: ButtonStyle {

//    let colors: [Color]
//    let stroke: Color
//    let shadow: Color
    
    let role: ButtonTypeEnum
    
    
    
    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .frame(height: 54)
//            .frame(maxWidth: .infinity)
//            .background(
//                LinearGradient(colors: colors, startPoint: .bottom, endPoint: .top)
//                    .shadow(.inner(color: shadow, radius: 1, x: 0, y: -3))
//            )
//            .clipShape(RoundedRectangle(cornerRadius: 18))
//            .overlay(alignment: .center) {
//                RoundedRectangle(cornerRadius: 18, style: .continuous)
//                    .stroke(stroke, lineWidth: 0.5)
//            }
//            .foregroundStyle(colors.count != 1 ? .white : .black)
//            .font(.system(size: 18, weight: .bold, design: .rounded))
        configuration.label
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(role.color)
            .foregroundStyle(role.text)
            .clipShape(Capsule())
    }
}

extension ButtonStyle where Self == MainButton {
    static func mainButton(_ role: ButtonTypeEnum = .submit) -> MainButton {
        MainButton(role: role)
    }
//    static var mainButton: MainButton { .init(colors: [.white], stroke: .gray800, shadow: .gray500)}
//    static func mainButton(_ colors: [Color], stroke: Color, shadow: Color) -> MainButton {
//        MainButton(colors: colors, stroke: stroke, shadow: shadow)
//    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    VStack(spacing: 16) {
        Spacer()

        Button("Send") {
            print("Send")
        }
        .buttonStyle(.mainButton())
        Button("Cancel") {
            print("First action")
        }
        .buttonStyle(.mainButton(.cancel))
    }
    .padding(22)
})
