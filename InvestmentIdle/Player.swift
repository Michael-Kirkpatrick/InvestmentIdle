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
    private let currencyFormatter = NumberFormatter()
    
    init() {
        money = 0
        investmentLevels = []
        currencyFormatter.locale = Locale(identifier: "en_US")
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 0
    }
    
    func incrementMoney(amount: UInt) {
        lock.lock()
        money += amount
        lock.unlock()
    }
    
    func getMoney() -> UInt {
        return self.money
    }
    
    func getMoneyAsString() -> String {
        return currencyFormatter.string(from: NSNumber(value: money))!
    }
}
