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
    
    // Returns boolean value based upon whether or not the investment was actually upgraded.
    func levelUpInvestment(cost: UInt) -> Bool {
        var canAfford : Bool = false
        lock.lock() // Prevent any alteration of money while we detect whether or not the player can afford an upgrade, prevents any sort of multithreaded scenarios of upgrading two investments at once when you cannot afford both
        canAfford = self.money >= cost
        if canAfford {
            self.money -= cost
        }
        lock.unlock()
        return canAfford
    }
    
    func getMoney() -> UInt {
        return self.money
    }
    
    func getMoneyAsString() -> String {
        return CurrencyFormatter.getFormattedString(value: self.money)
    }
}
