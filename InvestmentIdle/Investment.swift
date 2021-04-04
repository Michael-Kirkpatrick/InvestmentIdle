//
//  Investment.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import Foundation

typealias Investment = InvestmentClass & InvestmentProtocol

class InvestmentClass {
    let title : String
    var level : UInt
    var incomePerTenSeconds : UInt
    
    init(incomePerTenSeconds : UInt, level : UInt, title : String) {
        self.incomePerTenSeconds = incomePerTenSeconds
        self.level = level
        self.title = title
    }
}

// Use protocol to enforce "virtual" type methods that aren't implemented in this class but must be implemented in subclasses
protocol InvestmentProtocol {
    func calcIncomePerTenSeconds(level: UInt) -> UInt
}
