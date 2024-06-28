//
//  ImageInput.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import SwiftUI


struct ImageInput: View {
    
//    @Binding var hasReceipt: Bool
    @Binding var receiptEnum: ReceiptEnum?
    @Binding var receiptPicker: SheetEnum?
    
    @State var showReceiptButtons: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader {
                let width = ($0.size.width / 2) - 10
                HStack {
                    VStack(alignment: .leading) {
                        Text("Receipt")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                        HStack(spacing: 18) {
                            VStack(alignment: .center) {
                                HStack(alignment: .center) {
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Image("receipt")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundStyle(receiptEnum != nil ? .purple400 : .gray900).animation(.easeIn, value: receiptEnum)
                                    }
                                    .frame(width: 26, height: 26, alignment: .center)
                                    Spacer()
                                    VerticalDivider()
                                    Spacer()
                                    Button(receiptEnum != nil ? "Delete" : "Add") {
                                        if receiptEnum == nil {
                                            withAnimation(.smooth) {
                                                showReceiptButtons.toggle()
                                            }
                                        } else {
                                            receiptEnum = nil
                                            showReceiptButtons = false
                                        }
                                    }
                                    .buttonStyle(.customCapsule)
                                    Spacer()
                                }
                            }
                            .customInputField(width)
                            
                            if showReceiptButtons {
                                VStack(alignment: .center) {
                                    HStack(alignment: .center) {
                                        Spacer()
                                        VStack {
                                            Button(action: {
                                                receiptPicker = .library
                                            }, label: {
                                                Image("picture")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .foregroundStyle(receiptEnum == .image ? .purple400 : .gray900)
                                            })
                                        }
                                        .frame(width: 26, height: 26)
                                        Spacer()
                                        VerticalDivider()
                                        Spacer()
                                        VStack {
                                            Button(action: {
                                                receiptPicker = .camera
                                            }, label: {
                                                Image("camera")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .foregroundStyle(receiptEnum == .photo ? .purple400 : .gray900)
                                            })
                                        }
                                        .frame(width: 26, height: 26)
                                        Spacer()
                                    }
                                }
                                .customInputField(width)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
//    ImageInput(hasReceipt: .constant(false), receiptPicker: .constant(.camera))
    VStack {
        ImageInput(receiptEnum: .constant(nil), receiptPicker: .constant(nil), showReceiptButtons: false)
        Spacer()
    }
}
