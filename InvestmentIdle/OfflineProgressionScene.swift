//
//  OfflineProgressionScene.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/16/21.
//

import SpriteKit
import GameplayKit

class OfflineProgressionScene : SKScene {
    private var offlineProgression : UInt = 0
    
    let titleFontSize : CGFloat = 32
    let fontSize : CGFloat = 20
    let buttonBoxSizeScale : CGFloat = 2.5
    let buttonBottomMargin : CGFloat = 0.2
    let closeButtonName = "closeOfflineProgression"
    
    func setOfflineProgression(offlineProgression : UInt) {
        self.offlineProgression = offlineProgression
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let title = SKLabelNode(text: "Offline Progression")
        title.fontColor = SKColor.black
        title.fontName = fontNameBold
        title.fontSize = titleFontSize
        title.position = CGPoint(x: self.frame.midX, y: self.frame.height / 3 * 2)
        self.addChild(title)
        
        let text = "Your investments generated \(CurrencyFormatter.getFormattedString(value: self.offlineProgression)) while you were away!"
        let attrString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttributes([NSAttributedString.Key.foregroundColor : SKColor.black, NSAttributedString.Key.font: UIFont(name: fontName, size: fontSize)!], range: range)
        let progression = SKLabelNode()
        progression.attributedText = attrString
        progression.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        progression.numberOfLines = 0
        progression.preferredMaxLayoutWidth = self.frame.width * 5 / 6
        self.addChild(progression)
        
        let closeButtonText = SKLabelNode(text: "Continue")
        closeButtonText.fontColor = SKColor.black
        closeButtonText.fontName = fontName
        closeButtonText.fontSize = fontSize
        closeButtonText.position = CGPoint(x: 0, y: 0)
        closeButtonText.verticalAlignmentMode = .center
        let textFrameSize = closeButtonText.calculateAccumulatedFrame()
        
        let closeButtonBackground = SKShapeNode(rectOf: CGSize(width: textFrameSize.width * buttonBoxSizeScale, height: textFrameSize.height * buttonBoxSizeScale))
        closeButtonBackground.fillColor = SKColor.lightGray
        closeButtonBackground.position = CGPoint(x: self.frame.midX, y: self.frame.height * buttonBottomMargin)
        closeButtonBackground.name = closeButtonName
        closeButtonBackground.addChild(closeButtonText)
        self.addChild(closeButtonBackground)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            
            if theNode.name == closeButtonName || theNode.parent?.name == closeButtonName {
                let background : SKNode = (theNode.name == closeButtonName) ? theNode : theNode.parent!
                UIHelper.simulateButtonPressSync(button: background, codeToRun: {
                    let transition = SKTransition.moveIn(with: SKTransitionDirection.right, duration: 1)
                    self.view?.presentScene(GameScene(size: self.size), transition: transition)
                })
            }
        }
    }
}
