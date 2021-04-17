//
//  GameCenter.swift
//  InvestmentIdle
//
//  Created by Vibhav Dindyal on 2021-04-14.
//

import GameKit

class GameCenter {
    
    static let shared = GameCenter()
    //private var localPlayer = GKLocalPlayer.local
    private let leaderboardID = "com.topinvestors.investmentidle"
    private var leaderboard: GKLeaderboard?
    private(set) var isGameCenterEnabled: Bool = false
    
    // Made private to prevent instances aside from the shared singleton from being created
    private init() {
        
    }
    
    // Login the player to GC if they are not already
    func authenticateLocalPlayer(presentingVC: UIViewController) {
        GKLocalPlayer.local.authenticateHandler = {viewController, error in
            if let vc = viewController {
                presentingVC.present(vc, animated: true, completion: nil)
                return
            }
            if error != nil {
                self.isGameCenterEnabled = false
                print("Local player could not be authenticated!")
                print(error!)
                return
            }
            self.isGameCenterEnabled = true
            self.displayLeaderboard(gameVC: presentingVC as! GameViewController)
        }
    }
    
    func updateScore(with value: Int) {
        GKLeaderboard.submitScore(value, context: value, player: GKLocalPlayer.local, leaderboardIDs: [self.leaderboardID], completionHandler: {error in
            if error != nil {
                print("Error updating score -- \(error!)")
            }
        })
    }
    
    func displayLeaderboard(gameVC: GameViewController) {
        if (!GameCenter.shared.isGameCenterEnabled) {
            authenticateLocalPlayer(presentingVC: gameVC)
        }
        else {
            self.updateScore(with: Int(Player.sharedPlayer.getMoney()))
            let gcVC = GKGameCenterViewController(state: .leaderboards)
            gcVC.gameCenterDelegate = gameVC
            gameVC.displayGameCenterLeaderboards(gcVC: gcVC)
        }
    }
    
    func displayLeaderboard(scene: SKScene) {
        let gameVC = scene.view!.window!.rootViewController as! GameViewController
        self.displayLeaderboard(gameVC: gameVC)
    }
}
