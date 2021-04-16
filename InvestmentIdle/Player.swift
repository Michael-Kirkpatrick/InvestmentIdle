//
//  Player.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import Foundation

private let MAX_IDLE_TIME : TimeInterval = 86400 // Seconds in a day

class Player: Codable {
    static let sharedPlayer = Player()
    private var money : UInt
    private var investmentLevels : [String : UInt]
    private var lastSaveDate : Date
    private let lock = NSLock()
    
    init() {
        money = 0
        investmentLevels = [:]
        lastSaveDate = Date()
    }
    
    func incrementMoney(amount: UInt) {
        lock.lock()
        money += amount
        lock.unlock()
    }
    
    // Returns boolean value based upon whether or not the investment was actually upgraded.
    func levelUpInvestment(investment: InvestmentClass) -> Bool {
        var canAfford : Bool = false
        lock.lock() // Prevent any alteration of money while we detect whether or not the player can afford an upgrade, prevents any sort of multithreaded scenarios of upgrading two investments at once when you cannot afford both
        canAfford = self.money >= investment.upgradeCost
        if canAfford {
            self.money -= investment.upgradeCost
            incrementInvestmentLevel(investmentTitle: investment.title)
        }
        lock.unlock()
        return canAfford
    }
    
    func incrementInvestmentLevel(investmentTitle: String) {
        if (self.investmentLevels[investmentTitle] != nil) {
            self.investmentLevels[investmentTitle]! += 1
        } else {
            self.investmentLevels[investmentTitle] = 1
        }
    }
    
    func getMoney() -> UInt {
        return self.money
    }
    
    func getMoneyAsString() -> String {
        return CurrencyFormatter.getFormattedString(value: self.money)
    }
    
    func getInvestmentLevel(investmentTitle: String) -> UInt {
        return self.investmentLevels[investmentTitle] ?? 0
    }
    
    // MARK: Persistent Data
    private let fileName = "InvestmentIdle"
    private var fileURL : URL {
        let documentDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent(fileName)
    }
    
    // Specify encoding/decoding only of money and investment levels
    private enum CodingKeys: String, CodingKey {
        case money, investmentLevels, lastSaveDate
    }
    
    func loadPlayer() {
        let jsonDecoder = JSONDecoder()
        var data = Data()
        do {
            data = try Data(contentsOf: fileURL)
        } catch {
            print("Cannot read Player data.")
        }
        do {
            let savedPlayer = try jsonDecoder.decode(Player.self, from: data)
            self.money = savedPlayer.money
            self.investmentLevels = savedPlayer.investmentLevels
            self.lastSaveDate = savedPlayer.lastSaveDate
            
            // Calculate offline progression since last save
            let elapsedTime = min(abs(self.lastSaveDate.timeIntervalSinceNow), MAX_IDLE_TIME)
            let elapsedGenerationCycles : UInt = UInt(elapsedTime) / 10
            var moneyGenerated : UInt = 0
            for (investmentName, investmentLevel) in investmentLevels {
                switch (investmentName) {
                case LemonadeStand.title:
                    moneyGenerated += (LemonadeStand.calcIncomePerTenSeconds(level: investmentLevel) * elapsedGenerationCycles)
                case ScalpingBot.title:
                    moneyGenerated += (ScalpingBot.calcIncomePerTenSeconds(level: investmentLevel) * elapsedGenerationCycles)
                case StockTradingAlgorithm.title:
                    moneyGenerated += (StockTradingAlgorithm.calcIncomePerTenSeconds(level: investmentLevel) * elapsedGenerationCycles)
                case CryptoMiner.title:
                    moneyGenerated += (CryptoMiner.calcIncomePerTenSeconds(level: investmentLevel) * elapsedGenerationCycles)
                case StartUp.title:
                    moneyGenerated += (StartUp.calcIncomePerTenSeconds(level: investmentLevel) * elapsedGenerationCycles)
                default:
                    print("Unexpected investmentName found in Player's saved investments: \(investmentName)")
                }
            }
            
            self.incrementMoney(amount: moneyGenerated)
            
        } catch {
            print("Cannot decode Player data from the archive.")
        }
    }
    
    func savePlayer() {
        self.lastSaveDate = Date() // Set last save date before saving so that it can be used to calculate offline progression
        let jsonEncoder = JSONEncoder()
        var data = Data()
        do {
            data = try jsonEncoder.encode(self)
        } catch {
            print("Cannot encode Player.")
        }
        do {
            try data.write(to: fileURL, options: [])
        } catch {
            print("Cannot write Player data to file.")
        }
    }
}
