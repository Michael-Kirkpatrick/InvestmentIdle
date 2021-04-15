//
//  LemonadeStand.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import Foundation

class LemonadeStand: Investment {
    
    static func calcUpgradeCost(level: UInt) -> UInt {
        return level * 2 + 1
    }

    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level
    }
    
    init(level: UInt) {
        super.init(level: level, title: "Lemonade Stand", incomeFunction: LemonadeStand.calcIncomePerTenSeconds, upgradeCostFunction: LemonadeStand.calcUpgradeCost)
    }
}
