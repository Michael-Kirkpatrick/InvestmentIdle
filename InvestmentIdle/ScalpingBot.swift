//
//  ScalpingBot.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class ScalpingBot: Investment {
    static let title = "Scalping Bot"
    
    static func calcUpgradeCost(level: UInt) -> UInt {
        return level * 20 + 25
    }
    
    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level * 10
    }
    
    init(level: UInt) {
        super.init(level: level, title: ScalpingBot.title, incomeFunction: ScalpingBot.calcIncomePerTenSeconds, upgradeCostFunction: ScalpingBot.calcUpgradeCost)
    }
    
}
