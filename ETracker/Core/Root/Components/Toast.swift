////
////  Toast.swift
////  ETracker
////
////  Created by Ancel Dev account on 13/7/24.
////
//
//import SwiftUI
//
//struct ToastDataModel {
//    var title: String
//    var image: String
//}
//
//struct Toast<Content>: View where Content: View {
////    let data: ToastDataModel
//
//    @ViewBuilder
//    let content: () -> Content
//
//    @Binding var show: Bool
//
//    init(content: @escaping () -> Content, show: Bool) {
////        self.data = data
//        self.content = content
//        self.show = show
//    }
//
//
//    var body: some View {
//        VStack {
//            HStack {
////                Image(systemName: data.image)
////                Text(data.title)
//                content()
//            }
//            .foregroundStyle(.purple700)
//            .padding()
//            .background(.purple100)
//
//        }
//        .frame(maxWidth: .infinity)
//        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
//        .onTapGesture {
//            withAnimation {
//                self.show = false
//            }
//        }
//        .onAppear(perform: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                withAnimation {
//                    self.show = false
//                }
//            }
//        })
//    }
//}
//
//struct ToastModifier: ViewModifier {
//    @Binding var show: Bool
//    @ViewBuilder
//    let toastView: () -> View
//    //    let toastView: Toast
//    func body(content: Content) -> some View {
//        ZStack {
//            content
//            if show {
//                toastView
//            }
//        }
//    }
//}
//
//extension View {
//    func toast(toastView: Toast, show: Binding<Bool>) -> some View {
//        modifier(ToastModifier.init(show: show, toastView: toastView))
//    }
//}
//
//#Preview {
//    Toast(data: .init(title: "Test Toast", image: "checkmark"), show: .constant(true))
//}

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    @Environment(\.dismiss) var dismiss
    let toastView: AnyView
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    VStack {
                        Spacer()
                        toastView
                            .foregroundStyle(.black)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Exit")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                        })
                        .frame(width: 196, height: 46)
                        .background(
                            LinearGradient(colors: purpleButton, startPoint: .bottom, endPoint: .top)
                                .shadow(.inner(color: .purple400, radius: 1, x: 0, y: -3))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.purple700, lineWidth: 1)
                        }
                    }
                    .padding(20)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 248)
                .background(
                    Image("testreceipt")
                        .opacity(0.2)
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
    TestView()
}
