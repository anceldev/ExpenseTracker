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
    let imageName: String?
    let autoCorrectionDisabled: Bool
    @ViewBuilder var inputField: () -> InputField
    

    init(title: String, text: String, imageName: String? = nil, autoCorrectionDisabled: Bool, @ViewBuilder inputField: @escaping () -> InputField) {
        self.title = title
        self.text = text
        self.imageName = imageName
        self.autoCorrectionDisabled = autoCorrectionDisabled
        self.inputField = inputField
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.gray600)
            HStack {
                if let image = imageName {
                    VStack {
                        Image(systemName: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24)
                            .foregroundStyle(text.count >= 3 ? .iris500 : .gray500.opacity(0.85))
                    }
                    .frame(width: 26)
                    .padding(.leading, 18)
                }
                inputField()
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .autocorrectionDisabled(autoCorrectionDisabled)
                    .padding(.leading, 18)
                Spacer()
            }
            .customInputField(.infinity)
        }
    }
}

#Preview {
    VStack {
        CustomInputField(title: "Email", text: "Email", imageName: "user", autoCorrectionDisabled: true) {
//            TextField("", text: .constant(""))
            TextField("Email", text: .constant(""), prompt: Text("Enter email"))
        }
        CustomInputField(title: "Password", text: "Enter Password", imageName: "key" , autoCorrectionDisabled: true) {
            SecureField("Password", text: .constant(""))
        }
        
        CustomInputField(title: "Password", text: "Enter Password", autoCorrectionDisabled: true) {
            SecureField("Password", text: .constant(""))
        }
    }
    .padding()
}
