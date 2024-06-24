//
//  CustomInputField.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import SwiftUI

struct CustomInputField<InputField: View>: View where InputField: View {
    
    let title: String
    let text: String
    let imageName: String
    let autoCorrectionDisabled: Bool
    @ViewBuilder var inputField: () -> InputField
    

    init(title: String, text: String, imageName: String, autoCorrection: Bool, @ViewBuilder inputField: @escaping () -> InputField) {
        self.title = title
        self.text = text
        self.imageName = imageName
        self.autoCorrectionDisabled = autoCorrection
        self.inputField = inputField
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
            HStack(spacing: 16) {
                VStack {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(text.count >= 3 ? .purple400 : .black)
                }
                .frame(width: 26)
                .padding(.leading, 19)
                
                VerticalDivider()
                
                inputField()
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .autocorrectionDisabled(autoCorrectionDisabled)
                
                Spacer()
            }
            .customInputField(.infinity)
        }
    }
}

#Preview {
    VStack {
        CustomInputField(title: "Email", text: "Email", imageName: "user", autoCorrection: false) {
            TextField("", text: .constant(""))
        }
    }
}
