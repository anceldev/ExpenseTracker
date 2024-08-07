//
//  CategoryPicker.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import SwiftUI

struct CategoryPicker: View {
    /// Customization Properties
    var hint: String
    //    var options: [String]
    var anchor: Anchor = .bottom
    
//    var viewModel: CategoriesViewModel
    
    @Binding var selectedCategory: TransactionCategory?
    @Environment(CategoriesViewModel.self) var categoriesViewModel
    /// View Properties
    @State private var showOptions: Bool = false
    /// Environment Scheme
    
    @Environment(\.colorScheme) private var scheme
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex: Double = 1000.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Category")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.gray600)
            GeometryReader {
                let size = $0.size
                VStack(spacing: 0) {
                    if showOptions && anchor == .top {
                        OptionsView()
                            .zIndex(zIndex)
                    }
                    HStack {
                        HStack(spacing: 20) {
                            VStack {
                                Image("dropdownselect")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 26)
                                    .rotationEffect(.degrees(showOptions ? 180 : 270))
                                    .foregroundStyle(selectedCategory != nil ? .iris600 : .gray1K4)
                            }
                            VerticalDivider()
                            
                            Text(selectedCategory?.name ?? hint)
                                .foregroundStyle(selectedCategory == nil ? .gray1K4 : .iris600)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .lineLimit(1)
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 15)
                        .onTapGesture {
                                index += 1
                                zIndex = index
                                withAnimation(.snappy) {
                                    showOptions.toggle()
                                }
                        }
                        .zIndex(10)
                        NavigationLink {
                            AddCategory()
                                .environment(categoriesViewModel)
                                .navigationBarBackButtonHidden()
                        } label: {
                            Label("Add Category", systemImage: "plus")
                                .labelStyle(.iconOnly)
                                .foregroundStyle(.white)
                                .frame(width: 36, height: 36)
                                .background(
                                    .iris600
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .id(UUID())
                        .padding(.trailing, 19)
                    }
                    .frame(width: size.width, height: 53)
                    .background(.white)
                }
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray200.opacity(0.6), lineWidth: 2)
                }
                .frame(height: size.height, alignment: anchor == .top ? .bottom : .top)
            }
            .frame(height: 53)
//            .frame(width: .infinity, height: 53)
        }
    }
    
    /// Options View
    @ViewBuilder
    func OptionsView() -> some View {
        ScrollView(.vertical) {
            ForEach(categoriesViewModel.categories) { category in
                HStack(spacing: 0) {
                    Text(category.name)
                        .lineLimit(1)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                    Spacer(minLength: 0)
                }
                .foregroundStyle(selectedCategory?.id == category.id ? .iris800 : .gray1K3)
                .foregroundStyle(.iris900)
                .animation(.none, value: selectedCategory)
                .frame(height: 40)
                .contentShape(.rect)
                .onTapGesture {
                    zIndex = -1
                    selectedCategory = category
                    withAnimation {
                        showOptions = false
                        /// Closing Drop Down View
                    }
                    zIndex = 1000.0
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .frame(minHeight: 180)
        .transition(.move(edge: anchor == .top ? .bottom : .top))
        .background(.gray100)
    }
    /// Drop Down Direction
    enum Anchor {
        case top
        case bottom
    }
}

#Preview(body: {
    NavigationStack {
//        CategoryPicker(hint: "Picker",anchor: .bottom, viewModel: CategoriesViewModel(), selectedCategory: .constant(nil))
//            .environment(CategoriesViewModel())
        CategoryPicker(hint: "Picker",anchor: .bottom, selectedCategory: .constant(nil))
            .environment(CategoriesViewModel())
    }
})
