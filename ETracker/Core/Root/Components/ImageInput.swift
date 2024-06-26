//
//  ImageInput.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import SwiftUI


struct ImageInput: View {
    
    @Binding var hasReceipt: Bool
    @Binding var receiptPicker: SheetEnum?
    
    @State var showReceiptButtons: Bool = true
    
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
                                            .foregroundStyle(hasReceipt ? .purple400 : .gray900).animation(.easeIn, value: hasReceipt)
                                    }
                                    .frame(width: 26, height: 26, alignment: .center)
                                    Spacer()
                                    VerticalDivider()
                                    Spacer()
                                    Button(hasReceipt ? "Delete" : "Add") {
                                        if !hasReceipt {
                                            withAnimation(.smooth) {
                                                showReceiptButtons.toggle()
                                            }
                                        } else {
                                            hasReceipt = false
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
                                                    .foregroundStyle(hasReceipt ? .purple400 : .gray900)
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
                                                    .foregroundStyle(hasReceipt ? .purple400 : .gray900)
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
    }
}

#Preview {
    ImageInput(hasReceipt: .constant(false), receiptPicker: .constant(.camera))
}
