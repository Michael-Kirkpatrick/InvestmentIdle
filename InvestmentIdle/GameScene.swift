//
//  GameScene.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let fontName = "Avenir-Medium"
    let fontNameBold = "Avenir-Black"
    let fontNameLight = "Avenir-Light"
    let headerFont = "Avenir-HeavyOblique"
    
    let headerHeightScale : CGFloat = 1/10
    let headerEdgeSafety : CGFloat = 10
    let headerSpacingXScale : CGFloat = 1/6
    let headerSpacingYScale : CGFloat = 1/3
    
    let investmentFrameSpacingScale : CGFloat = 1/32
    let investmentFrameHeightScale : CGFloat = 1/8
    let investmentFrameWidthScale : CGFloat = 0.8
    
    let investmentItemSpacingScale : CGFloat = 1/16
    let investmentItemHeightScale : CGFloat = 1/4
    let statusBarTextScale : CGFloat = 3/4
    
    var investmentsPlaced : CGFloat = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let header = createHeaderUI()
        self.addChild(header)
        
        let lemonadeStand = LemonadeStand(level: 1)
        let lem2 = LemonadeStand(level: 34)
        
        let investmentUI = createinvestmentUI(investment: lemonadeStand)
        let lem2UI = createinvestmentUI(investment: lem2)
        
        self.addChild(investmentUI)
        self.addChild(lem2UI)
    }
    
    func createHeaderUI() -> SKShapeNode {
        let safeAreaInsets = self.view?.safeAreaInsets.top ?? 0
        
        let frame = SKShapeNode(rectOf: CGSize(width: self.frame.width + headerEdgeSafety, height: self.frame.height * headerHeightScale + safeAreaInsets + headerEdgeSafety))
        let frameSize = frame.calculateAccumulatedFrame().size
        frame.fillColor = SKColor.lightGray
        frame.position = CGPoint(x: self.frame.midX, y: self.frame.height - frameSize.height / 2 + headerEdgeSafety / 2)
        
        let label = SKLabelNode(text: "$1,000,000")
        label.fontColor = SKColor.black
        label.fontName = headerFont
        
        let spaceToFit = CGSize(width: frameSize.width - headerEdgeSafety - headerSpacingXScale * frameSize.width, height: frameSize.height - safeAreaInsets - headerEdgeSafety - headerSpacingYScale * (frameSize.height - safeAreaInsets))
        label.fontSize *= getFontScale(spaceToFit: spaceToFit, labelToFit: label.frame.size)
        
        label.position = CGPoint(x: 0, y: -frameSize.height / 2 + (frameSize.height - safeAreaInsets) * headerSpacingYScale / 4)
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.bottom
        frame.addChild(label)
        
        return frame
    }
    
    func createinvestmentUI(investment: Investment) -> SKShapeNode {
        let safeAreaInsets = self.view?.safeAreaInsets.top ?? 0
        
        // FRAME START
        let frame = SKShapeNode(rectOf: CGSize(width: self.frame.width * investmentFrameWidthScale, height: self.frame.height * investmentFrameHeightScale))
        frame.strokeColor = SKColor.black
        let offsetToOtherInvestments = investmentFrameHeightScale * investmentsPlaced + investmentFrameSpacingScale * (investmentsPlaced + 1)
        let frameYOffsetScale = headerHeightScale + investmentFrameHeightScale / 2 + offsetToOtherInvestments
        frame.position = CGPoint(x: self.frame.midX, y: self.frame.height - safeAreaInsets - self.frame.height * frameYOffsetScale)
        let frameSize = frame.calculateAccumulatedFrame().size
        // FRAME END
        
        // TITLE START
        let title = SKLabelNode(text: investment.title)
        title.fontColor = SKColor.black
        title.fontName = fontNameBold
        
        // Scale the font size to meet the size of the area we want this label to go (1/4 of height and 1 width maximum)
        var spaceToFit = CGSize(width: frameSize.width * (1 - investmentItemSpacingScale), height: frameSize.height * investmentItemHeightScale)
        title.fontSize *= getFontScale(spaceToFit: spaceToFit, labelToFit: title.frame.size)
        
        title.position = CGPoint(x: -frameSize.width / 2 + frameSize.width * (investmentItemSpacingScale / 2) + title.frame.width / 2, y: frameSize.height / 2 - frameSize.height * investmentItemSpacingScale - title.frame.height / 2)
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        frame.addChild(title)
        // TITLE END
        
        // LEVEL LABEL START
        let levelLabel = SKLabelNode(text: "Level \(investment.level)")
        levelLabel.fontColor = SKColor.black
        levelLabel.fontName = fontName
        
        levelLabel.fontSize *= getFontScale(spaceToFit: spaceToFit, labelToFit: levelLabel.frame.size)
        let xPosition = -frameSize.width / 2 + frameSize.width * (investmentItemSpacingScale / 2) + levelLabel.frame.width / 2
        levelLabel.position = CGPoint(x: xPosition, y: 0)
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        frame.addChild(levelLabel)
        // LEVEL LABEL END
        
        // STATUS BAR START
        let statusBar = SKShapeNode(rectOf: spaceToFit)
        let statusBarSizeOffset = statusBar.calculateAccumulatedFrame().size.height / 2
        let yPosition = -frameSize.height / 2 + frameSize.height * investmentItemSpacingScale + statusBarSizeOffset
        statusBar.position = CGPoint(x: 0, y: yPosition)
        statusBar.strokeColor = SKColor.black
        frame.addChild(statusBar)
        // STATUS BAR END
        
        // STATUS BAR LABEL START
        let statusBarLabel = SKLabelNode(text: "$\(investment.incomePerTenSeconds)")
        statusBarLabel.fontColor = SKColor.black
        statusBarLabel.fontName = fontNameLight
        
        spaceToFit.width *= statusBarTextScale
        spaceToFit.height *= statusBarTextScale
        statusBarLabel.fontSize *= getFontScale(spaceToFit: spaceToFit, labelToFit: statusBarLabel.frame.size)
        
        statusBarLabel.position = CGPoint(x: 0, y: yPosition)
        statusBarLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        frame.addChild(statusBarLabel)
        // STATUS BAR LABEL END
        
        investmentsPlaced += 1 // Keep record of how many investmentUI's there are so that future frames are properly positioned
        return frame
    }
    
    func getFontScale(spaceToFit: CGSize, labelToFit: CGSize) -> CGFloat {
        return min(spaceToFit.width / labelToFit.width, spaceToFit.height / labelToFit.height)
    }
}

