//
//  currencyFormatter.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/14/21.
//

import Foundation

class CurrencyFormatter {
    static let currencyFormatter = NumberFormatter()
    
    init() {
        CurrencyFormatter.currencyFormatter.locale = Locale(identifier: "en_US")
        CurrencyFormatter.currencyFormatter.usesGroupingSeparator = true
        CurrencyFormatter.currencyFormatter.numberStyle = .currency
        CurrencyFormatter.currencyFormatter.maximumFractionDigits = 0
    }
    
    static func getFormattedString(value: UInt) -> String {
        return CurrencyFormatter.currencyFormatter.string(from: NSNumber(value: value))!
    }
}
