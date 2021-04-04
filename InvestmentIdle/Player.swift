//
//  Player.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import Foundation

class Player {
    static let sharedPlayer = Player()
    var money : UInt
    var investmentLevels : [UInt]
    
    init() {
        money = 0
        investmentLevels = []
    }
}
