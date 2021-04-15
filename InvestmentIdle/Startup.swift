//
//  StartUp.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class StartUp: Investment {
    
    static func calcUpgradeCost(level: UInt) -> UInt {
        return level * level * 3 + level * 200 + 10000
    }
    
    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level * 100
    }
    
    init(level: UInt) {
        super.init(level: level, title: "StartUp", incomeFunction: StartUp.calcIncomePerTenSeconds, upgradeCostFunction: StartUp.calcUpgradeCost)
    }

}
