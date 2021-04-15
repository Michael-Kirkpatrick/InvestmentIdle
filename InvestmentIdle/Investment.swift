//
//  Investment.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import Foundation
import SpriteKit
import GameplayKit

typealias Investment = InvestmentClass & InvestmentProtocol

class InvestmentClass {
    let title : String
    var level : UInt
    var incomePerTenSeconds : UInt
    let incomeFunction:(_ level: UInt) -> UInt
    private var loadingBar: SKShapeNode?
    private var statusBar: SKShapeNode?
    static let threadQueue = DispatchQueue(label: "generateQueue", attributes: .concurrent)
    
    init(incomePerTenSeconds : UInt, level : UInt, title : String, incomeFunction:@escaping (_ level : UInt) -> UInt) {
        self.incomePerTenSeconds = incomePerTenSeconds
        self.level = level
        self.title = title
        self.incomeFunction = incomeFunction
    }

    func generateMoney(scene: SKScene) {
        let frame = scene.childNode(withName: self.title) as! SKShapeNode
        statusBar = frame.childNode(withName: self.title + "StatusBar") as? SKShapeNode
        loadingBar = statusBar?.childNode(withName: self.title + "LoadingBar") as? SKShapeNode
        
        let scaleUp = SKAction.scaleX(to: 1, duration: 10.0)
        let scaleDown = SKAction.scaleX(to: 0, duration: 0)
        let moveRight = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 10.0)
        let moveLeft = SKAction.move(to: CGPoint(x: -(statusBar?.frame.width)! / 2, y: 0), duration: 0)
        
        loadingBar?.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.group([
                    scaleUp,
                    moveRight
                ]),
                SKAction.run{self.incrementPlayerMoney()},
                SKAction.group([
                    scaleDown,
                    moveLeft
                ])
            ])
        ))
    }
    
    @objc func incrementPlayerMoney() {
        Player.sharedPlayer.incrementMoney(amount: self.incomeFunction(self.level))
        UIHelper.updateHeaderLabel()
    }
    
}

// Use protocol to enforce "virtual" type methods that aren't implemented in this class but must be implemented in subclasses
protocol InvestmentProtocol {
    static func calcIncomePerTenSeconds(level: UInt) -> UInt
}
