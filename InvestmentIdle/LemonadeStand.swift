//
//  LemonadeStand.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import Foundation

class LemonadeStand: Investment {

    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level
    }
    
    init(level: UInt) {
        super.init(incomePerTenSeconds: 0, level: level, title: "Lemonade Stand", incomeFunction: LemonadeStand.calcIncomePerTenSeconds)
        self.incomePerTenSeconds = LemonadeStand.calcIncomePerTenSeconds(level: self.level)
    }
}
