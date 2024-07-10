//
//  CategoriesRow.swift
//  ETracker
//
//  Created by Ancel Dev account on 28/6/24.
//

import SwiftUI

struct CategoriesRow: View {
    @Environment(CategoriesViewModel.self) var viewModel
    @Binding var selected: TransactionCategory?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                HStack(spacing: 25) {
                    ForEach(viewModel.categories) { category in
                        Button(action: {
                            withAnimation(.spring) {
                                if category.id == selected?.id {
                                    selected = nil
                                } else {
                                    selected = category
                                }
                            }
                        }, label: {
                            RoundedButton(
                                iconName: category.icon.rawValue,
                                selected: category.id == self.selected?.id,
                                buttonName: category.name.capitalized
                            )
                        })
                    }
                }
            }
            .padding(.horizontal, 19)
            .padding(.vertical, 19)
            .frame(maxWidth: .infinity )
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    CategoriesRow(selected: .constant(nil))
        .environment(CategoriesViewModel())
        .background(.red.opacity(0.6))
})
