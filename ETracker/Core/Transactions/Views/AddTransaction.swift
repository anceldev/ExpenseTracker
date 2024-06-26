//
//  AddTransaction.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

enum SheetEnum: Identifiable, Hashable {
    case library
    case camera
    case datePicker
    
    var id: Self { self }
}
enum ReceiptEnum: Identifiable, Hashable {
    case photo
    case image
    
    var id: Self { self }
}

struct AddTransaction: View {
 
    @Environment(\.dismiss) private var dismiss
    
    var viewModel: TransactionsViewModel
    var categoriesViewModel = CategoriesViewModel()
    
    @State var transactionKind: Transaction.Kind = .income
    @State var amount: Double = 0.0
    @State var concept: String = ""
    @State var timestamp: Date? = nil
    
    @State var showDatePicker = false
    @State var showReceiptButtons = false
    
    @State var selectedSheet: SheetEnum?
    @State var showReceiptPicker: Bool = false
    
    @State var imageReceipt = UIImage()
    @State var receiptEnum: ReceiptEnum? = nil
    
    
    init(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        UISegmentedControl.appearance().selectedSegmentTintColor = .purple600
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.white], for: .selected)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Text("Add transaction")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                HStack {
                    Picker("Kind", selection: $transactionKind) {
                        Text("Income")
                            .tag(Transaction.Kind.income)
                        Text("Expense")
                            .tag(Transaction.Kind.expense)
                    }
                    .pickerStyle(.segmented)
                }
            }
            VStack(spacing: 12) {
                CustomInputField(title: "Concept", text: concept, imageName: "cheapdollar", autoCorrectionDisabled: false) {
                    TextField("Concept", text: $concept)
                }
                MoneyInput(title: "Amount", amount: amount) {
                    TextField("", value: $amount, formatter: NumberFormatter())
                }
                DateInput(showPicker: $selectedSheet, timestamp: timestamp)
                ImageInput(receiptEnum: $receiptEnum, receiptPicker: $selectedSheet)
            }
            Spacer()
            VStack {
                Button(action: {
//                    viewModel.createTransaction(concept: concept, amount: amount, transactionKind: transactionKind, category: category, timestamp: timestamp, receipt: receiptEnum == nil ? nil : imageReceipt)
                }, label: {
                    Text("Add Transaction")
                })
                .buttonStyle(.mainButton(purpleButton, stroke: .purple700, shadow: .purple400))
            Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
            })
            .buttonStyle(.mainButton)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .sheet(item: $selectedSheet) { sheet in
            switch sheet {
            case .library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: $imageReceipt, receiptEnum: $receiptEnum)
            case .camera:
                ImagePicker(sourceType: .camera, selectedImage: $imageReceipt, receiptEnum: $receiptEnum)
            case .datePicker:
                CustomNilDatePicker(title: "Transaction Date", pickedDate: $timestamp)
            }
        }
    }
}
struct MyDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        return max(50, context.maxDetentValue * 0.75)
    }
}
#Preview {
    AddTransaction(viewModel: TransactionsViewModel())
}
