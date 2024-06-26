//
//  TestView.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import SwiftUI

struct TestView: View {
    /// View Properties
    @State private var selection: String?
    @State private var selection1: String?
    @State private var selection2: String?
    
    var viewModel = CategoriesViewModel()
    @State var selectedCategory: Transaction.Category? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                CategoryPicker(
                    hint: "Select",
                    anchor: .top,
                    viewModel: viewModel,
                    selectedCategory: $selectedCategory
                )
                Button("I'm Button") {
                    
                }
            }
            .navigationTitle("Dropdown Picker")
        }
    }
}


#Preview {
    TestView()
}
