//
//  StockTradingAlgorithm.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class StockTradingAlgorithm: Investment {
    
    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level * 20
    }
    
    init(level: UInt) {
        super.init(incomePerTenSeconds: 0, level: level, title: "Stock Trading Algorithm", incomeFunction: StockTradingAlgorithm.calcIncomePerTenSeconds)
        self.incomePerTenSeconds = StockTradingAlgorithm.calcIncomePerTenSeconds(level: self.level)
    }
}
