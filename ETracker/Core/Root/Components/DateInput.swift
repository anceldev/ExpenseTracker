//
//  DateInput.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct DateInput: View {
    
//    @Binding var showPicker: Bool
    let title: String?
    @Binding var showPicker: SheetEnum?
    var timestamp: Date?
    
    init(title: String? = nil, showPicker: Binding<SheetEnum?>, timestamp: Date? = nil) {
        self.title = title
        self._showPicker = showPicker
        self.timestamp = timestamp
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
            }
            HStack(spacing: 20) {
                VStack {
                    Button(action: {
//                        showPicker.toggle()
                        showPicker = .datePicker
                        print("Showing date picker...")
                    }, label: {
                        Image("calendarclock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(timestamp != nil ? .iris500 : .black)
                    })
                }
                .frame(width: 26)
                .padding(.leading, 19)
                
                VerticalDivider()
                
                if let date = timestamp {
                    Text(date, style: .date)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.iris600)
                    
                } else {
                    Text("Select date")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                Spacer()
            }
            .customInputField(.infinity)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    VStack(spacing: 16) {
        DateInput(title: "Test Date", showPicker: .constant(.datePicker))
        DateInput(title: "Test Date 2", showPicker: .constant(nil), timestamp: .now)
    }
    .padding()
})
