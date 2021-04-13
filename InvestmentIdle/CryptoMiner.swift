//
//  CryptoMiner.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class CryptoMiner: Investment {
    
    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level * 50
    }
    
    init(level: UInt) {
        super.init(incomePerTenSeconds: 0, level: level, title: "Crypto Miner", incomeFunction: CryptoMiner.calcIncomePerTenSeconds)
        self.incomePerTenSeconds = CryptoMiner.calcIncomePerTenSeconds(level: self.level)
    }
}
