//
//  GameScene.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import SpriteKit
import GameplayKit

let fontName = "Avenir-Medium"
let fontNameBold = "Avenir-Black"
let fontNameLight = "Avenir-Light"
let headerFont = "Avenir-HeavyOblique"

class GameScene: SKScene {
    let investmentFrameSpacingScale : CGFloat = 1/32
    let investmentFrameHeightScale : CGFloat = 1/8
    let investmentFrameWidthScale : CGFloat = 0.8
    
    let investmentItemSpacingScale : CGFloat = 1/16
    let investmentItemHeightScale : CGFloat = 1/4
    let statusBarTextScale : CGFloat = 3/4
    
    var investmentsPlaced : CGFloat = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        UIHelper.currentScene = self
        let header = UIHelper.createHeaderUI()
        self.addChild(header)
        
//        let lemonadeStand = LemonadeStand(level: 1)
//        let cryptoMiner = CryptoMiner(level: 1)
//        let stockTrader = StockTradingAlgorithm(level: 1)
//        let scalpingBot = ScalpingBot(level: 1)
        let startUp = StartUp(level: 25)
        startUp.generateMoney()
        
//        let investmentUI = createinvestmentUI(investment: lemonadeStand)
//        let cryptoMinerUI = createinvestmentUI(investment: cryptoMiner)
//        let stockTraderUI = createinvestmentUI(investment: stockTrader)
//        let scalpingBotUI = createinvestmentUI(investment: scalpingBot)
        let startUpUI = createinvestmentUI(investment: startUp)
        
//        self.addChild(investmentUI)
//        self.addChild(cryptoMinerUI)
//        self.addChild(stockTraderUI)
//        self.addChild(scalpingBotUI)
        self.addChild(startUpUI)
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
        frame.name = investment.title
        // FRAME END
        
        // TITLE START
        let title = SKLabelNode(text: investment.title)
        title.fontColor = SKColor.black
        title.fontName = fontNameBold
        
        // Scale the font size to meet the size of the area we want this label to go (1/4 of height and 1 width maximum)
        var spaceToFit = CGSize(width: frameSize.width * (1 - investmentItemSpacingScale), height: frameSize.height * investmentItemHeightScale)
        title.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: title.frame.size)
        
        title.position = CGPoint(x: -frameSize.width / 2 + frameSize.width * (investmentItemSpacingScale / 2) + title.frame.width / 2, y: frameSize.height / 2 - frameSize.height * investmentItemSpacingScale - title.frame.height / 2)
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        frame.addChild(title)
        // TITLE END
        
        // LEVEL LABEL START
        let levelLabel = SKLabelNode(text: "Level \(investment.level)")
        levelLabel.fontColor = SKColor.black
        levelLabel.fontName = fontName
        
        levelLabel.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: levelLabel.frame.size)
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
        statusBarLabel.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: statusBarLabel.frame.size)
        
        statusBarLabel.position = CGPoint(x: 0, y: yPosition)
        statusBarLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        frame.addChild(statusBarLabel)
        // STATUS BAR LABEL END
        
        investmentsPlaced += 1 // Keep record of how many investmentUI's there are so that future frames are properly positioned
        return frame
    }
    
    // Register appropriate actions for when the user clicks the various buttons on screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            
            // Load InvestmentScene for the given investment
            if theNode.name == "Lemonade Stand" {
                let transition = SKTransition.moveIn(with:SKTransitionDirection.right, duration: 1)
                let investmentScene = InvestmentScene(size: self.size)
                self.view?.presentScene(investmentScene, transition: transition)
            }
        }
    }
}

