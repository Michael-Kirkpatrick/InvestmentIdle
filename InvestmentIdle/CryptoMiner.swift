//
//  CryptoMiner.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-12.
//

import Foundation

class CryptoMiner: Investment {
    
    static func calcUpgradeCost(level: UInt) -> UInt {
        return level * 500 + 1000
    }
    
    static func calcIncomePerTenSeconds(level : UInt) -> UInt {
        return level * 50
    }
    
    init(level: UInt) {
        super.init(level: level, title: "Crypto Miner", incomeFunction: CryptoMiner.calcIncomePerTenSeconds, upgradeCostFunction: CryptoMiner.calcUpgradeCost)
    }
}
