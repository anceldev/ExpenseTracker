//
//  AddCategory.swift
//  ETracker
//
//  Created by Ancel Dev account on 6/8/24.
//

import SwiftUI

struct AddCategory: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(CategoriesViewModel.self) var viewModel
    @State var selectedIcon: TransactionCategory.Icon = .briefcase
    @State var categoryName: String = ""
    @State var selectedColor: Color = .red
    
    let columns = [GridItem(.adaptive(minimum: 40))]
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .center, spacing: 16) {
                VStack {
                    Image(systemName: selectedIcon.rawValue)
                        .font(.system(size: 44))
                        .foregroundStyle(.white)
                }
                .frame(width: 96, height: 96)
                .background {
                    LinearGradient(colors: [selectedColor.opacity(0.9), selectedColor.opacity(0.65)], startPoint: .bottom, endPoint: .top)
                }
                .clipShape(.circle)
                .shadow(color: selectedColor.opacity(0.6), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                TextField("Name", text: $categoryName, prompt: Text("Name"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(categoryName == "" ? .gray500 : selectedColor)
                    .background(.gray100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 1)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(Color.defaultColors, id:\.self) { color in
                        Button(action: {
                            withAnimation(.snappy) {
                                selectedColor = color
                            }
                        }, label: {
                            
                            ZStack {
                                Circle()
                                    .fill(color)
                                    .padding(2)
                                Circle()
                                    .strokeBorder(selectedColor == color ? .gray400 : .white, lineWidth: 3)
                                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                            }
                            .frame(width: 40)
                        })
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(TransactionCategory.Icon.allCases) { icon in
                        Button(action: {
                            withAnimation(.snappy) {
                                selectedIcon = icon
                            }
                        }, label: {
                            ZStack {
                                Circle()
                                    .fill(.gray100)
                                    .overlay {
                                        Image(systemName: icon.rawValue)
                                            .foregroundStyle(.gray700)
                                    }
                                    .padding(2)
                                Circle()
                                    .strokeBorder(selectedIcon == icon ? .gray400 : .white, lineWidth: 3)
                                    .scaleEffect(CGSize(width: 1.2, height: 1.2))
                            }
                            .frame(width: 40)
                        })
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack {
                Button(action: {
                    print("Adding category...")
//                    viewModel.createTransaction(concept: concept, amount: amount, transactionKind: transactionKind, category: selectedCategory!, timestamp: timestamp, receipt: receiptEnum == nil ? nil : imageReceipt)
//                    withAnimation {
//                        showToast.toggle()
//                    }
                    viewModel.createCategory(name: categoryName, icon: selectedIcon, hexColor: selectedColor.toHex())
                    dismiss()
                }, label: {
                    Text("Add Category")
                })
                .buttonStyle(.mainButton())
//                .disabled(selectedCategory == nil)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray300)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Add Category")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Label("Back", systemImage: "chevron.left")
                })
                .buttonStyle(.plain)
                .foregroundStyle(.gray700)
                .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddCategory()
            .environment(CategoriesViewModel())
    }
}
