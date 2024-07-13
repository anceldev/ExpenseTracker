//
//  AddSubscription.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import SwiftUI

struct AddSubscription: View {
    
    @Environment(SubscriptionsViewModel.self) var viewModel
    
    @State var service = ""
    @State var amount: Double = 0.0
    @State var billing: ETSubscription.Billing = .monthly
    @State var chargeDate: Date = .now
    @State var activeSubscription = false
    @State var activeNotification = false
    
    @State var chargeDateSheet: SheetEnum?
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .purple600
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.white], for: .selected)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            VStack(alignment: .leading) {
                Text("Add Subscription")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            }
            ScrollView(.vertical) {
                VStack(spacing: 12, content: {
                    CustomInputField(title: "Service", text: service, imageName: "cheapdollar", autoCorrectionDisabled: false) {
                        TextField("Type", text: $service)
                    }
                    MoneyInput(title: "Amount", amount: amount) {
                        TextField("", value: $amount, formatter: NumberFormatter.moneyFormatter)
                    }
                    VStack(alignment: .leading){
                        Text("Billing")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        Picker("Billing", selection: $billing) {
                            ForEach(ETSubscription.Billing.allCases) { type in
                                Text(type.rawValue)
                                    .tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    DateInput(title: "Charge date", showPicker: $chargeDateSheet, timestamp: chargeDate)
                    HStack {
                        Text("Active Subscription")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        Spacer(minLength: 0)
                        Toggle("Is active?", isOn: $activeSubscription)
                            .labelsHidden()
                            .tint(.purple400)
                    }
                    .padding(.trailing, 5)
                    VStack(alignment: .leading) {
                        Text("Notification")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        HStack(spacing: 10) {
                            DateInput(showPicker: $chargeDateSheet, timestamp: chargeDate)
                            Spacer(minLength: 0)
                            Toggle("Notification On", isOn: $activeNotification)
                                .labelsHidden()
                                .tint(.purple400)
                        }
                        .padding(.trailing, 5)
                    }
                })
            }
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .sheet(item: $chargeDateSheet) { sheet in
            switch sheet {
            case .library:
                Text("Library")
            case .camera:
                Text("Camera")
            case .datePicker:
                Text("Date picker")
            }
        }
    }
}

#Preview {
    AddSubscription()
        .environment(SubscriptionsViewModel())
}
