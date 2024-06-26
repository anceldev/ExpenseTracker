//
//  DateInput.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct DateInput: View {
    
//    @Binding var showPicker: Bool
    @Binding var showPicker: SheetEnum?
    var timestamp: Date?
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Date")
                .font(.system(size: 18, weight: .bold, design: .rounded))
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
                            .foregroundStyle(timestamp != nil ? .purple400 : .black)
                    })
                }
                .frame(width: 26)
                .padding(.leading, 19)
                
                VerticalDivider()
                
                if let date = timestamp {
                    Text(date, style: .date)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.purple400)
                    
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
        DateInput(showPicker: .constant(.datePicker))
        DateInput(showPicker: .constant(nil), timestamp: .now)
    }
    .padding()
})
