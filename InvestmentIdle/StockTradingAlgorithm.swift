//
//  StockTradingAlgorithm.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class StockTradingAlgorithm: Investment {
    
    init(level: UInt) {
        super.init(incomePerTenSeconds: 0, level: level, title: "Stock Trading Algorithm")
        self.incomePerTenSeconds = calcIncomePerTenSeconds(level: self.level)
    }
    
    func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level
    }
}
