//
//  CustomTabBar.swift
//  ETracker
//
//  Created by Ancel Dev account on 2/7/24.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Environment(TransactionsViewModel.self) var viewModel
    @Binding var selectedTab: Tab
    
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(animation: animation, tab: .home , selectedTab: $selectedTab)
            TabBarButton(animation: animation,  tab: .subscriptions , selectedTab: $selectedTab)
            
//            Button {
//                
//            } label: {
//                Image(systemName: "plus")
//                    .resizable()
//                    .renderingMode(.template)
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 15)
//                    .foregroundStyle(.white)
////                    .padding(10)
//                    .padding(15)
//                    .background(
//                        LinearGradient(colors: purpleButton, startPoint: .bottom, endPoint: .top)
//                            .shadow(.inner(color: .purple400, radius: 1, x: 0, y: -3))
//                    )
//                    .clipShape(.circle)
//                    .overlay {
//                        Circle()
//                            .stroke(.purple700, lineWidth: 1)
//                    }
//                    .fontWeight(.bold)
//            }
            
            NavigationLink {
                AddTransaction()
                    .environment(viewModel)
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15)
                    .foregroundStyle(.white)
                    .padding(15)
                    .background(
                        LinearGradient(colors: purpleButton, startPoint: .bottom, endPoint: .top)
                            .shadow(.inner(color: .purple400, radius: 1, x: 0, y: -3))
                    )
                    .clipShape(.circle)
                    .overlay {
                        Circle()
                            .stroke(.purple700, lineWidth: 1)
                    }
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 15)
            

            TabBarButton(animation: animation, tab: .analytics , selectedTab: $selectedTab)
            TabBarButton(animation: animation, tab: .settings , selectedTab: $selectedTab)
        }
        .background(.white)
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
        .padding(.bottom, 34)
        .padding(.horizontal, 15)

    }
}

struct TabBarButton: View {
    var animation: Namespace.ID
    var tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                self.selectedTab = tab
            }
        } label: {
            VStack(spacing: 0) {
                Image(systemName: selectedTab == tab ? "\(tab.icon).fill" : tab.icon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28)
                    .foregroundStyle(self.selectedTab == tab ? .purple700.opacity(0.7) : .gray )

            }
            .frame(maxWidth: .infinity)
        }

    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    VStack {
        Spacer()
        CustomTabBar(selectedTab: .constant(.home))
            .environment(TransactionsViewModel())
    }
})
