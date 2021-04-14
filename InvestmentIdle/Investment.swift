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
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.incrementPlayerMoney), userInfo: nil, repeats: true)
        let frame = scene.childNode(withName: self.title) as! SKShapeNode
        statusBar = frame.childNode(withName: self.title + "StatusBar") as? SKShapeNode
        loadingBar = statusBar?.childNode(withName: self.title + "LoadingBar") as? SKShapeNode
        Timer.scheduledTimer(timeInterval: 1.0 / 30, target: self, selector: #selector(self.changeLoadingBar), userInfo: nil, repeats: true)
    }
    
    @objc func changeLoadingBar() {
        loadingBar?.xScale += 1 / 300
        let xPos = -(statusBar?.frame.width)!/2+loadingBar!.frame.width/2
        loadingBar!.position = CGPoint(x: xPos+1, y:0)
        if(loadingBar!.xScale > 1) {
            loadingBar?.xScale = 0
            loadingBar!.position = CGPoint(x: xPos+1, y:0)
        }
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
