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
    @Environment(TransactionsViewModel.self) var viewModel
    @Environment(CategoriesViewModel.self) var categoriesViewModel
    
    @State var transactionKind: Transaction.Kind = .income
    @State var amount: Double = 0.0
    @State var concept: String = ""
    @State var timestamp: Date = .now
    
    
    @State var selectedCategory: TransactionCategory? = nil
    
    @State var showDatePicker = false
    @State var selectedSheet: SheetEnum?
    @State var showReceiptPicker: Bool = false
    
    @State var imageReceipt = UIImage()
    @State var receiptEnum: ReceiptEnum? = nil
    
    @State var showToast = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .iris600
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
                CustomInputField(title: "Concept", text: concept, autoCorrectionDisabled: false) {
                    TextField("Type concept", text: $concept)
                }
                
                MoneyInput(title: "Amount", amount: amount) {
                    TextField("", value: $amount, formatter: NumberFormatter.moneyFormatter)
                }
                DateInput(title: "Date", showPicker: $selectedSheet, timestamp: timestamp)
                CategoryPicker(hint: "Select", anchor: .top, selectedCategory: $selectedCategory)
                    .environment(categoriesViewModel)
                ImageInput(receiptEnum: $receiptEnum, receiptPicker: $selectedSheet)
                    .padding(.trailing, 19)
            }
            .padding(.horizontal, 2)
            VStack {
                Button(action: {
                    print("Adding category...")
                    self.showToast = viewModel.createTransaction(concept: concept, amount: amount, transactionKind: transactionKind, category: selectedCategory!, timestamp: timestamp, receipt: receiptEnum == nil ? nil : imageReceipt)
                    withAnimation {
                        showToast.toggle()
                    }
                }, label: {
                    Text("Add Transaction")
                })
                .buttonStyle(.mainButton())
                .disabled(selectedCategory == nil)
                
                Button(action: {
                    print("Canceling new transaction")
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
                .buttonStyle(.mainButton(.cancel))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
        .toast(isShowing: $showToast) {
            Text("¡Transaction Added!")
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
                .buttonStyle(.plain)
                .fontWeight(.semibold)
                .foregroundStyle(.gray700)
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
    NavigationStack {
        AddTransaction()
            .environment(TransactionsViewModel())
            .environment(CategoriesViewModel())
    }
}
