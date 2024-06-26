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
    var options: [String]
    var anchor: Anchor = .bottom

    var viewModel: CategoriesViewModel
    
    @Binding var selection: String?
    /// View Properties
    @State private var showOptions: Bool = false
    /// Environment Scheme
    
    @Environment(\.colorScheme) private var scheme
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex: Double = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack(spacing: 0) {
                if showOptions && anchor == .top {
                    OptionsView()
                }
                HStack {
                    HStack(spacing: 20) {
                        VStack {
                            Image("dropdownselect")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 26)
                                .rotationEffect(.degrees(showOptions ? 180 : 270))
                                .foregroundStyle(selection != nil ? .purple700 : .gray1K4)
                        }
                        VerticalDivider()
                        
                        Text(selection ?? hint)
                            .foregroundStyle(selection == nil ? .gray1K4 : .purple700)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .lineLimit(1)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 15)
//                    .frame(width: size.width, height: 60)
//                    .background(scheme == .dark ? .black : .white)
//                    .contentShape(.rect)
                    .onTapGesture {
                        index += 1
                        zIndex = index
                        withAnimation(.snappy) {
                            showOptions.toggle()
                        }
                    }
                    .zIndex(10)
                    NavigationLink {
                        Text("Add New category")
                    } label: {
                        Label("Add Category", systemImage: "plus")
                            .labelStyle(.iconOnly)
                            .foregroundStyle(.white)
                            .frame(width: 36, height: 36)
                            .background(
                                LinearGradient(colors: purpleButton, startPoint: .bottom, endPoint: .top)
                                    .shadow(.inner(color: .purple400, radius: 1, x: 0, y: -3))
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.trailing, 19)
                }
                .frame(width: size.width, height: 60)
//                .background(scheme == .dark ? .black : .white)
                .background(.white)
                
                if showOptions && anchor == .bottom {
                    OptionsView()
                }
            }
            .clipped()
            /// Clips All Interaction within it's bounds
//            .contentShape(.rect)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.gray300, lineWidth: 1)
//                (scheme == .dark ? Color.black : Color.white).shadow(.drop(color: .primary.opacity(0.15), radius: 4)), in: .rect(cornerRadius: 12)
            )
            .frame(height: size.height, alignment: anchor == .top ? .bottom : .top)
        }
        .frame(width: .infinity, height: 60)
        .zIndex(zIndex)
    }
    
    /// Options View
    @ViewBuilder
    func OptionsView() -> some View {
        ScrollView(.vertical) {
            ForEach(options, id: \.self) { option in
                HStack(spacing: 0) {
                    Text(option)
                        .lineLimit(1)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "checkmark")
                        .font(.caption)
                        .opacity(selection == option ? 1 : 0)
                        .padding(.trailing, 16)
                }
                .foregroundStyle(selection == option ? .purple900 : .gray1K3)
                .animation(.none, value: selection)
                .frame(height: 50)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        /// Closing Drop Down View
                        showOptions = false
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .frame(minHeight: 180)
        .transition(.move(edge: anchor == .top ? .bottom : .top))
        .background(.gray100.opacity(0.4))
    }
        
    
    /// Drop Down Direction
    enum Anchor {
        case top
        case bottom
    }
}

//
//#Preview {
//    NavigationStack {
//        TestView()
//            .padding()
//    }
//}
#Preview(body: {
//    CategoryPicker(hint: "Picker", options: [
//        "YouTube",
//        "Instagram",
//        "X (Twitter)",
//        "Snapchat",
//        "TikTok"
//    ],anchor: .bottom,viewModel: CategoriesViewModel(), selection: .constant("Nice"))
//    .padding()
    CategoryPicker(hint: "Picker", options: [
        "YouTube",
        "Instagram",
        "X (Twitter)",
        "Snapchat",
        "TikTok"
    ],anchor: .bottom, viewModel: CategoriesViewModel(), selection: .constant("Nice"))
    .padding()

})
