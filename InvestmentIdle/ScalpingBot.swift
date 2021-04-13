//
//  ScalpingBot.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class ScalpingBot: Investment {
    
    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level * 10
    }
    
    init(level: UInt) {
        super.init(incomePerTenSeconds: 0, level: level, title: "Scalping Bot", incomeFunction: ScalpingBot.calcIncomePerTenSeconds)
        self.incomePerTenSeconds = ScalpingBot.calcIncomePerTenSeconds(level: self.level)
    }
    
}
