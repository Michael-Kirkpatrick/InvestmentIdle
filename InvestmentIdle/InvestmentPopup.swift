//
//  InvestmentPopup.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/13/21.
//

import SpriteKit
import GameplayKit

class InvestmentPopup {
    let popupHeightScale : CGFloat = 0.6
    let popupWidthScale : CGFloat = 0.75
    let popupWidthMarginScale : CGFloat = 0.1
    let popupHeightMarginScale : CGFloat = 0.05
    
    let textHeightScale : CGFloat = 0.07
    
    let closeButtonName = "closeInvestmentPopupButton"
    
    private let frame : SKShapeNode
    private let title : SKLabelNode
    private let level : SKLabelNode
    private let upgradeCost : SKLabelNode
    private let currentIncome : SKLabelNode
    private let nextIncome : SKLabelNode
    private let scene : SKScene
    private let spaceToFit : CGSize
    
    
    init(scene : SKScene) {
        var yOffset : CGFloat = 0
        
        self.scene = scene
        frame = SKShapeNode(rectOf: scene.frame.size)
        frame.zPosition = -1
        frame.alpha = 0
        frame.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        frame.name = "InvestmentPopup"
        
        let innerFrame = SKShapeNode(rectOf: CGSize(width: scene.frame.width * popupWidthScale, height: scene.frame.height * popupHeightScale))
        innerFrame.strokeColor = SKColor.black
        innerFrame.fillColor = SKColor.lightGray
        innerFrame.position = CGPoint(x: 0, y: 0)
        frame.addChild(innerFrame)
        var frameSize = innerFrame.calculateAccumulatedFrame().size
        frameSize.height *= (1-popupHeightMarginScale)
        frameSize.width *= (1-popupWidthMarginScale)
        
        let closeButton = SKLabelNode(text: "Close")
        closeButton.fontColor = SKColor.black
        closeButton.fontName = fontName
        spaceToFit = CGSize(width: frameSize.width, height: frameSize.height * textHeightScale)
        closeButton.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: closeButton.frame.size)
        closeButton.position = CGPoint(x: 0, y: -frameSize.height / 2)
        closeButton.name = closeButtonName
        innerFrame.addChild(closeButton)
        
        let closeButtonBackground = SKShapeNode(rectOf: CGSize(width: closeButton.frame.width * 1.2, height: closeButton.frame.height * 1.2))
        closeButtonBackground.fillColor = SKColor.gray
        closeButtonBackground.position = CGPoint(x: 0, y: closeButton.frame.height / 2)
        closeButtonBackground.strokeColor = SKColor.black
        closeButton.addChild(closeButtonBackground)
        
        title = SKLabelNode(text: "Lemonade Stand")
        title.fontColor = SKColor.black
        title.fontName = fontNameBold
        title.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: title.frame.size)
        title.position = CGPoint(x: 0, y: frameSize.height / 2 - title.frame.height)
        innerFrame.addChild(title)
        yOffset += title.frame.height + popupHeightMarginScale * frameSize.height
        
        level = SKLabelNode(text: "Level: 0")
        level.fontColor = SKColor.black
        level.fontName = fontName
        level.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: level.frame.size)
        level.position = CGPoint(x: -frameSize.width / 2, y: frameSize.height / 2 - yOffset - level.frame.height)
        level.horizontalAlignmentMode = .left
        innerFrame.addChild(level)
        yOffset += level.frame.height + popupHeightMarginScale * frameSize.height
        
        upgradeCost = SKLabelNode(text: "Upgrade Cost: $5")
        upgradeCost.fontColor = SKColor.black
        upgradeCost.fontName = fontName
        upgradeCost.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: upgradeCost.frame.size)
        upgradeCost.position = CGPoint(x: -frameSize.width / 2, y:frameSize.height / 2 - yOffset - upgradeCost.frame.height)
        upgradeCost.horizontalAlignmentMode = .left
        innerFrame.addChild(upgradeCost)
        yOffset += upgradeCost.frame.height + popupHeightMarginScale * frameSize.height
        
        let upgradeButton = SKShapeNode(rectOf: CGSize(width: spaceToFit.width * 0.8, height: spaceToFit.height))
        upgradeButton.fillColor = SKColor.gray
        upgradeButton.position = CGPoint(x: 0, y: frameSize.height / 2 - yOffset - upgradeButton.frame.height / 2)
        upgradeButton.strokeColor = SKColor.black
        innerFrame.addChild(upgradeButton)
        yOffset += upgradeButton.frame.height + popupHeightMarginScale * frameSize.height
        
        let upgradeButtonLabel = SKLabelNode(text: "Upgrade")
        upgradeButtonLabel.fontColor = SKColor.black
        upgradeButtonLabel.fontName = fontName
        upgradeButtonLabel.fontSize *= UIHelper.getFontScale(spaceToFit: CGSize(width: spaceToFit.width * 0.8, height: spaceToFit.height * 0.8), labelToFit: level.frame.size)
        upgradeButtonLabel.position = CGPoint(x: 0, y: 0)
        upgradeButtonLabel.verticalAlignmentMode = .center
        upgradeButton.addChild(upgradeButtonLabel)
        
        currentIncome = SKLabelNode(text: "Current Level: $0/10s")
        currentIncome.fontColor = SKColor.black
        currentIncome.fontName = fontName
        currentIncome.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: currentIncome.frame.size)
        currentIncome.position = CGPoint(x:-frameSize.width / 2, y: frameSize.height / 2 - yOffset - currentIncome.frame.height / 2)
        currentIncome.horizontalAlignmentMode = .left
        innerFrame.addChild(currentIncome)
        yOffset += currentIncome.frame.height + popupHeightMarginScale * frameSize.height
        
        nextIncome = SKLabelNode(text: "Next Level: $1/10s")
        nextIncome.fontColor = SKColor.black
        nextIncome.fontName = fontName
        nextIncome.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: nextIncome.frame.size)
        nextIncome.position = CGPoint(x:-frameSize.width / 2, y: frameSize.height / 2 - yOffset - nextIncome.frame.height / 2)
        nextIncome.horizontalAlignmentMode = .left
        innerFrame.addChild(nextIncome)
        
        let minFont = min(currentIncome.fontSize, nextIncome.fontSize)
        currentIncome.fontSize = minFont
        nextIncome.fontSize = minFont
    }
    
    func getPopup() -> SKShapeNode {
        return frame
    }
    
    func displayFrame(investment: InvestmentClass) {
        title.text = investment.title
        level.text = "Level: \(investment.level)"
        upgradeCost.text = "Upgrade Cost: NEW_FUNC"
        currentIncome.text = "Current Level: \(CurrencyFormatter.getFormattedString(value: investment.incomePerTenSeconds))/10s"
        nextIncome.text = "Next Level: \(CurrencyFormatter.getFormattedString(value: investment.incomeFunction(investment.level + 1)))/10s"
        
        title.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: title.frame.size)
        let fontSize = min(currentIncome.fontSize * UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: currentIncome.frame.size), nextIncome.fontSize * UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: nextIncome.frame.size), upgradeCost.fontSize * UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: upgradeCost.frame.size))
        level.fontSize = fontSize
        upgradeCost.fontSize = fontSize
        currentIncome.fontSize = fontSize
        nextIncome.fontSize = fontSize
        
        frame.zPosition = 50
        frame.alpha = 1
    }
    
    func hideFrame() {
        frame.zPosition = -1
        frame.alpha = 0
    }

}
