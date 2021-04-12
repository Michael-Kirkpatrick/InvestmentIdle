//
//  InvestmentScene.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/12/21.
//

import SpriteKit
import GameplayKit

class InvestmentScene : SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        UIHelper.currentScene = self
        let header = UIHelper.createHeaderUI()
        self.addChild(header)
        
    }
}
