//
//  GameViewController.swift
//  InvestmentIdle
//
//  Created by user194362 on 4/4/21.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = CurrencyFormatter() // Initialize this helper
        Player.sharedPlayer.loadPlayer()
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }

    func displayGameCenterLeaderboards(gcVC: GKGameCenterViewController) {
        present(gcVC, animated: true, completion: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
