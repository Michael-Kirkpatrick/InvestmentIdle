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
    
    let levelLabelNameSuffix = "LevelLabel"
    let incomeLabelNameSuffix = "IncomeLabel"
    
    var investmentPopup : InvestmentPopup?
    
    var investmentsPlaced : CGFloat = 0
    var investments : [String:InvestmentClass] = [:]
    
    private var upgradeInProgress : Bool = false
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        investmentPopup = InvestmentPopup(scene: self)
        self.addChild((investmentPopup?.getPopup())!)
        
        UIHelper.currentScene = self
        let header = UIHelper.createHeaderUI()
        self.addChild(header)
        
        var lemonadeStandLevel = Player.sharedPlayer.getInvestmentLevel(investmentTitle: LemonadeStand.title)
        if lemonadeStandLevel == 0 { // If 0, that means we have a first-time player, so give them one level in the first investment.
            lemonadeStandLevel = 1
            Player.sharedPlayer.incrementInvestmentLevel(investmentTitle: LemonadeStand.title)
        }
        let lemonadeStand = LemonadeStand(level: lemonadeStandLevel)
        let scalpingBot = ScalpingBot(level: Player.sharedPlayer.getInvestmentLevel(investmentTitle: ScalpingBot.title))
        let cryptoMiner = CryptoMiner(level: Player.sharedPlayer.getInvestmentLevel(investmentTitle: CryptoMiner.title))
        let stockTrader = StockTradingAlgorithm(level: Player.sharedPlayer.getInvestmentLevel(investmentTitle: StockTradingAlgorithm.title))
        let startUp = StartUp(level: Player.sharedPlayer.getInvestmentLevel(investmentTitle: StartUp.title))
        
        investments[lemonadeStand.title] = lemonadeStand
        investments[scalpingBot.title] = scalpingBot
        investments[stockTrader.title] = stockTrader
        investments[cryptoMiner.title] = cryptoMiner
        investments[startUp.title] = startUp
        
        let investmentUI = createinvestmentUI(investment: lemonadeStand)
        let scalpingBotUI = createinvestmentUI(investment: scalpingBot)
        let stockTraderUI = createinvestmentUI(investment: stockTrader)
        let cryptoMinerUI = createinvestmentUI(investment: cryptoMiner)
        let startUpUI = createinvestmentUI(investment: startUp)
        
        self.addChild(investmentUI)
        self.addChild(cryptoMinerUI)
        self.addChild(stockTraderUI)
        self.addChild(scalpingBotUI)
        self.addChild(startUpUI)
        
        for (_, investment) in investments {
            if investment.level > 0 {
                investment.generateMoney(scene: self)
            }
        }
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
        let levelLabel = SKLabelNode(text: "Level: \(investment.level)")
        levelLabel.fontColor = SKColor.black
        levelLabel.fontName = fontName
        levelLabel.name = investment.title + levelLabelNameSuffix
        
        levelLabel.fontSize *= UIHelper.getFontScale(spaceToFit: spaceToFit, labelToFit: levelLabel.frame.size)
        let xPosition = -frameSize.width / 2 + frameSize.width * (investmentItemSpacingScale / 2) + levelLabel.frame.width / 2
        levelLabel.position = CGPoint(x: xPosition, y: 0)
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        frame.addChild(levelLabel)
        // LEVEL LABEL END
        
        // STATUS BAR START
        let statusBar = SKShapeNode(rectOf: spaceToFit)
        statusBar.name = investment.title + "StatusBar"
        let statusBarSizeOffset = statusBar.calculateAccumulatedFrame().size.height / 2
        let yPosition = -frameSize.height / 2 + frameSize.height * investmentItemSpacingScale + statusBarSizeOffset
        statusBar.position = CGPoint(x: 0, y: yPosition)
        statusBar.strokeColor = SKColor.black
        frame.addChild(statusBar)
        // STATUS BAR END
        
        // Loading bar
        let loadingBar = SKShapeNode(rectOf: CGSize(width: statusBar.frame.width, height: statusBar.frame.height-2))
        loadingBar.xScale = 0
        loadingBar.name = investment.title + "LoadingBar"
        let xPos = -statusBar.frame.width/2+loadingBar.frame.width/2+1
        loadingBar.position = CGPoint(x: xPos, y:0)
        loadingBar.fillColor = SKColor.green
        loadingBar.strokeColor = SKColor.black
        statusBar.addChild(loadingBar)
        
        // STATUS BAR LABEL START
        let statusBarLabel = SKLabelNode(text: CurrencyFormatter.getFormattedString(value: investment.incomePerTenSeconds))
        statusBarLabel.fontColor = SKColor.black
        statusBarLabel.fontName = fontNameLight
        statusBarLabel.name = investment.title + incomeLabelNameSuffix
        
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
            for investmentName in investments.keys {
                if theNode.name == investmentName || theNode.parent?.name == investmentName {
                    let background : SKNode = (theNode.name == investmentName) ? theNode : theNode.parent!
                    UIHelper.simulateButtonPressSync(button: background, codeToRun: {
                        self.investmentPopup?.displayFrame(investment: self.investments[investmentName]!)
                    })
                }
            }
            if theNode.name == leaderBoardButtonName || theNode.parent?.name == leaderBoardButtonName {
                let background : SKNode = (theNode.name == leaderBoardButtonName) ? theNode : theNode.parent!
                UIHelper.simulateButtonPressSync(button: background, codeToRun: {
                    GameCenter.shared.displayLeaderboard(scene: self)
                })
            } else if (theNode.name == investmentPopup?.closeButtonName || theNode.parent?.name == investmentPopup?.closeButtonName) {
                let background : SKNode = (theNode.name == investmentPopup?.closeButtonName) ? theNode : theNode.parent!
                UIHelper.simulateButtonPressSync(button: background, codeToRun: {
                    self.investmentPopup?.hideFrame()
                })
            } else if (theNode.name == investmentPopup?.upgradeButtonName || theNode.parent?.name == investmentPopup?.upgradeButtonName) {
                if !upgradeInProgress {
                    let background : SKNode = (theNode.name == investmentPopup?.upgradeButtonName) ? theNode : theNode.parent!
                    UIHelper.simulateButtonPressAsync(button: background, codeToRun: {
                        self.upgradeInProgress = true // Prevent button from registering to level up until all models/views are up to date again
                        let currentInvestment = self.investmentPopup?.currentDisplayedInvestment
                        if let _ = currentInvestment?.levelUp() {
                            self.investmentPopup?.updateLabels(investment: currentInvestment!)
                            UIHelper.updateHeaderLabel()
                            let frame = self.childNode(withName: currentInvestment!.title)
                            let levelLabel = frame?.childNode(withName: currentInvestment!.title + self.levelLabelNameSuffix) as? SKLabelNode
                            levelLabel!.text = "Level: \(currentInvestment!.level)"
                            let incomeLabel = frame?.childNode(withName: currentInvestment!.title + self.incomeLabelNameSuffix) as? SKLabelNode
                            incomeLabel!.text = CurrencyFormatter.getFormattedString(value: currentInvestment!.incomePerTenSeconds)
                            
                            if currentInvestment!.level == 1 { // If we just upgraded to 1, need to start generating money for the first time
                                currentInvestment!.generateMoney(scene: self)
                            }
                        }
                        self.upgradeInProgress = false
                    })
                }
            }
        }
    }
}

