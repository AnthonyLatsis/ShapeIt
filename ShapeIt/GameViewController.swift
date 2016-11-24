//
//  GameViewController.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 21.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

enum GameMode {
    case regular
    case dynamic
}

class GameViewController: SIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = self.view as! SKView

        let scene = StaticGameScene(size: Screen.bounds.size)

        scene.scaleMode = .resizeFill
        
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
        view.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
