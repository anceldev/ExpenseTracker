//
//  TestView.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import SwiftUI

struct TestView: View {
    
    @State private var showToast = false
    @Environment(\.dismiss) var dismiss
    
    let data: [(Double, Color)] = [
                (1, .red),
                (1.5, .orange),
                (2.5, .yellow),
                (0.75, .green),
                (1.25, .blue),
                (2.85, .indigo),
                (0.15, .purple)
            ]
    
    var body: some View {
        VStack {
            Pie(slices: data)
                .frame(width: 250)
        }
        .toast(isShowing: $showToast) {
            Text("Transaction Added")
        }
    }
}

struct Pie: View {
    @State var slices: [(Double, Color)]
    
    var body: some View {
        Canvas { context, size in
            // Add these lines to display as Donut
            //Start Donut
            let donut = Path { p in
                p.addEllipse(
                    in: CGRect(origin: .zero,
                               size: size))
                p.addEllipse(
                    in: CGRect(
                        x: size.width * 0.25,
                        y: size.height * 0.25,
                        width: size.width * 0.5,
                        height: size.height * 0.5
                    )
                )
            }
            context.clip(to: donut, style: .init(eoFill: true))
            //End Donut
            let total = slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
            let gapSize = Angle(degrees: 5) // size of the gap between slices in degrees

            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle + Angle(degrees: 5) / 2, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    TestView()
}
