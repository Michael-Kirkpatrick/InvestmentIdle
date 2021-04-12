//
//  UIHelper.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/12/21.
//

import SpriteKit
import GameplayKit

let headerHeightScale : CGFloat = 1/10
let headerEdgeSafety : CGFloat = 10
let headerSpacingXScale : CGFloat = 1/6
let headerSpacingYScale : CGFloat = 1/3

class UIHelper {
    static var currentScene : SKScene?
    
    static func createHeaderUI() -> SKShapeNode {
        let safeAreaInsets = currentScene?.view?.safeAreaInsets.top ?? 0
        
        let frame = SKShapeNode(rectOf: CGSize(width: (currentScene?.frame.width)! + headerEdgeSafety, height: (currentScene?.frame.height)! * headerHeightScale + safeAreaInsets + headerEdgeSafety))
        let frameSize = frame.calculateAccumulatedFrame().size
        frame.fillColor = SKColor.lightGray
        frame.position = CGPoint(x: (currentScene?.frame.midX)!, y: (currentScene?.frame.height)! - frameSize.height / 2 + headerEdgeSafety / 2)
        frame.name = "HeaderFrame"
        
        let label = SKLabelNode(text: Player.sharedPlayer.getMoneyAsString())
        label.fontColor = SKColor.black
        label.fontName = headerFont
        label.name = "PlayerMoney"
        
        let spaceToFit = CGSize(width: frameSize.width - headerEdgeSafety - headerSpacingXScale * frameSize.width, height: frameSize.height - safeAreaInsets - headerEdgeSafety - headerSpacingYScale * (frameSize.height - safeAreaInsets))
        label.fontSize *= getFontScale(spaceToFit: spaceToFit, labelToFit: label.frame.size)
        
        label.position = CGPoint(x: 0, y: -frameSize.height / 2 + (frameSize.height - safeAreaInsets) * headerSpacingYScale / 4)
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.bottom
        frame.addChild(label)
        
        return frame
    }

    static func getFontScale(spaceToFit: CGSize, labelToFit: CGSize) -> CGFloat {
        return min(spaceToFit.width / labelToFit.width, spaceToFit.height / labelToFit.height)
    }
    
    static func updateHeaderLabel() {
        let header = currentScene!.childNode(withName: "HeaderFrame") as! SKShapeNode
        let headerLabel = header.childNode(withName: "PlayerMoney") as! SKLabelNode
        headerLabel.text = Player.sharedPlayer.getMoneyAsString()
    }
}

