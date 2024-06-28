//
//  CustomNilDatePicker.swift
//  ETracker
//
//  Created by Ancel Dev account on 25/6/24.
//

import SwiftUI

struct CustomNilDatePicker: View {
    @State var currentDate: Date
    @State var currentMonth: Int
    @State var newDate: Date
    
    
//    @Binding var pickedDate: Date?
    @Binding var pickedDate: Date
    var title: String?
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//    var datePicked: Bool {
//        if pickedDate == nil {
//            return false
//        }
//        return true
//    }
    
    @Environment(\.dismiss) var dismiss
    
    init(title: String? = nil, pickedDate: Binding<Date>) {
        self._currentDate = State(initialValue: .now)
        self._currentMonth = State(initialValue: 0)
        self._newDate = State(initialValue: .now)
        self._pickedDate = pickedDate
        self.title = title
    }
    
    var body: some View {
        VStack {
            ZStack {
                if title != nil {
                    Text(title!)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.gray1K3)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        CloseButton()
                    })
                }
            }
            HStack(spacing: 20, content: {
                Button(action: {
                    withAnimation {
                        currentMonth -= 1
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                })
                Spacer(minLength: 0)
                HStack(alignment: .center, spacing: 10, content: {
                    Text(extraDate()[0])
                    Text(extraDate()[1])
                })
                .font(.system(size: 28, weight: .semibold, design: .rounded))
                Spacer(minLength: 0)
                Button(action: {
                    withAnimation {
                        currentMonth += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.headline)
                })
            })
            .foregroundStyle(.gray1K3)
            .padding(.horizontal)
            .padding(.bottom, 25)
            
            HStack(spacing: 0, content: {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            })
            .padding(.bottom)
            .foregroundStyle(.gray1K)
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 8, content: {
                ForEach(extractDate()) { value in
                    CardDateView(value: value)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.purple200)
                                .frame(width: value.day != -1 ? 45 : 0)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            })
            Button(action: {
//                newDate = currentDate
//                withAnimation(.spring) {
//                    pickedDate = newDate
//                    currentDate = pickedDate!
//                }
                withAnimation(.spring) {
                    pickedDate = currentDate
                }
            }, label: {
                Text("Save")
            })
            .buttonStyle(.mainButton(purpleButton, stroke: .purple700, shadow: .purple400))
            Button(action: {
                withAnimation(.spring) {
                    currentDate = .now
                    pickedDate = currentDate
                    print("Picked date is now = nil \(String(describing: pickedDate))")
                }
            }, label: {
                Text("Clear")
            })
            .buttonStyle(.mainButton)
        }
        .padding(16)
        .onChange(of: currentMonth) { oldValue, newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    private func CardDateView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if isSameDay(date1: pickedDate, date2: value.date) {
                    Text("\(value.day)")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 45, height: 33)
                        .background(
                            LinearGradient(colors: purpleButton, startPoint: .bottom, endPoint: .top)
                                .shadow(.inner(color: .purple400, radius: 1, x: 0, y: -3))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else if isSameDay(date1: currentDate, date2: value.date) {
                    Text("\(value.day)")
                        .font(.headline)
                        .foregroundStyle(isSameDay(date1: value.date, date2: currentDate) ? .white : .black)
                        .background(
                            backgroundCardView(color: .purple200)
                        )
                } else {
                    Text("\(value.day)")
                        .foregroundStyle(isSameDay(date1: value.date, date2: currentDate) ? .white : .black)
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 30, alignment: .center)
    }
    
    @ViewBuilder
    private func backgroundCardView(color: Color) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .frame(width: 45, height: 33)
    }
    
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    private func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    private func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    private func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            let dateValue = DateValue(day: day, date: date)
            return dateValue
        }
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekDay - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    private struct DateValue: Identifiable {
        var id = UUID().uuidString
        var day: Int
        var date: Date
    }
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)
        return range!.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}


#Preview(traits: .sizeThatFitsLayout, body: {
    @State var pickedDate: Date = .now
    return  VStack {
        CustomNilDatePicker(title: "Title", pickedDate: $pickedDate)
        Text(pickedDate, style: .date)
    }
})
