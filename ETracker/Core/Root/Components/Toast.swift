////
////  Toast.swift
////  ETracker
////
////  Created by Ancel Dev account on 13/7/24.
////

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let toastView: AnyView
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    VStack(alignment: .center) {
                        Spacer()
                        toastView
                            .foregroundStyle(.white)
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                        Spacer()
                        
                        Button(action: {
                            print("Ok")
                        }, label: {
                            Text("Exit")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                        })
                        .buttonStyle(.customCapsule(color: .red))
                    }
                    .padding(20)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 248)
                .background(
                    LinearGradient(colors: [.iris600, .iris100], startPoint: .bottom, endPoint: .top)
                )
                .background(.gray100)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.gray200, lineWidth: 1)
                }
            }
        }
        .padding(.horizontal)
    }
}
extension View {
    func toast(isShowing: Binding<Bool>, @ViewBuilder toastView: () -> some View) -> some View {
        modifier(ToastModifier(isShowing: isShowing, toastView: AnyView(toastView())))
    }
}

#Preview {
    VStack {
        Text("Hello")
    }
    .toast(isShowing: .constant(true)) {
        Text("Transaction added succesfully")
    }
}
