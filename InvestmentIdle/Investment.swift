//
//  Investment.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import Foundation

typealias Investment = InvestmentClass & InvestmentProtocol

class InvestmentClass {
    let title : String
    var level : UInt
    var incomePerTenSeconds : UInt
    let incomeFunction:(_ level: UInt) -> UInt
    static let threadQueue = DispatchQueue(label: "generateQueue", attributes: .concurrent)
    
    init(incomePerTenSeconds : UInt, level : UInt, title : String, incomeFunction:@escaping (_ level : UInt) -> UInt) {
        self.incomePerTenSeconds = incomePerTenSeconds
        self.level = level
        self.title = title
        self.incomeFunction = incomeFunction
    }
    
    func generateMoney() {
        InvestmentClass.threadQueue.async {
            Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.incrementPlayerMoney), userInfo: nil, repeats: true)
        }
    }
    
    @objc func incrementPlayerMoney() {
        Player.sharedPlayer.incrementMoney(amount: self.incomeFunction(self.level))
        print(Player.sharedPlayer.getMoney())
    }
    
}

// Use protocol to enforce "virtual" type methods that aren't implemented in this class but must be implemented in subclasses
protocol InvestmentProtocol {
    func calcIncomePerTenSeconds(level: UInt) -> UInt
}
