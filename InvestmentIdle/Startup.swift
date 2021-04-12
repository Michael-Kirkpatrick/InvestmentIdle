//
//  StartUp.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class StartUp: Investment {
    
    func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level
    }
    
    init(level: UInt) {
        super.init(incomePerTenSeconds: 0, level: level, title: "StartUp", incomeFunction: calcIncomePerTenSeconds)
        self.incomePerTenSeconds = calcIncomePerTenSeconds(level: self.level)
    }

}
