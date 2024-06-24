//
//  NumberFormatter.swift
//  ETracker
//
//  Created by Ancel Dev account on 24/6/24.
//

import Foundation

extension NumberFormatter {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
}
