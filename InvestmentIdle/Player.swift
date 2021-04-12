//
//  Player.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import Foundation

class Player {
    static let sharedPlayer = Player()
    private var money : UInt
    private var investmentLevels : [UInt]
    private let lock = NSLock()
    
    init() {
        money = 0
        investmentLevels = []
    }
    
    func incrementMoney(amount: UInt) {
        lock.lock()
        money += amount
        lock.unlock()
    }
    
    func getMoney() -> UInt {
        return self.money
    }
    
}
