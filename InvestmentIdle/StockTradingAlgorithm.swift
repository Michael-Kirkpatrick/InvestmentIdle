//
//  StockTradingAlgorithm.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class StockTradingAlgorithm: Investment {
    
    static func calcUpgradeCost(level: UInt) -> UInt {
        return level * 100 + 200
    }
    
    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level * 20
    }
    
    init(level: UInt) {
        super.init(level: level, title: "Stock Trading Algorithm", incomeFunction: StockTradingAlgorithm.calcIncomePerTenSeconds, upgradeCostFunction: StockTradingAlgorithm.calcUpgradeCost)
    }
}
