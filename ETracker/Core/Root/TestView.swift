//
//  TestView.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import SwiftUI

struct TestView: View {
    
    @State private var showToast = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button("Show toast") {
                withAnimation {
                    showToast.toggle()
                }
            }
        }
        .toast(isShowing: $showToast) {
            Text("Transaction Added")
        }
    }
}


#Preview {
    TestView()
}
