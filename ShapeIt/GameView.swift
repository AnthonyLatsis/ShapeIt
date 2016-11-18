//
//  GameView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 16.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class GameView: SIView {
    let gameContainer = UIView()
    
    let switchModeButton = UIButton()
    
    init() {
        super.init(frame: Screen.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameView {
    override func setTargets() {
        switchModeButton.addTarget(self, action: #selector(catchEvent(in:)), for: .touchUpInside)
    }
    
    override func setUI() {
        insert(subviews: [gameContainer, switchModeButton], at: 10)
        
        self.backgroundColor = Style.lightPurple
        gameContainer.backgroundColor = .clear
        
        switchModeButton.backgroundColor = .white
        switchModeButton.titleLabel?.textAlignment = .center
        switchModeButton.setTitle("switch mode", for: .normal)
        switchModeButton.setTitleColor(.black, for: .normal)
    }
    
    override func setConstraints() {
        let views = [
            "gameContainer"   : gameContainer,
            "switchModeButton": switchModeButton
        ]
        let bezel = Style.bezel * 2
        
        let metrics: Dictionary<String, CGFloat> = ["bezel" : bezel]
        
        let gameContainerConstraints = [
            "V:|[gameContainer]-bezel-|",
            "H:|[gameContainer]|"
        ]
        let switchModeButtonConstraints = [
            "V:[gameContainer]-0-[switchModeButton]|",
            "H:|[switchModeButton]|"
        ]
        
        self.constraintsWith(VisualFormat: [
            gameContainerConstraints,
            switchModeButtonConstraints
        ], views: views, metrics: metrics)
    }
}

extension GameView {
    func insertGame(view: UIView) {
        gameContainer.insert(subviews: [view], at: 10)
        
        let views = ["view": view]
        
        let viewConstraints = [
            "V:|[view]|",
            "H:|[view]|"
        ]
        
        gameContainer.constraintsWith(VisualFormat: [viewConstraints], views: views)
    }
    
    func clearContainer() {
        for subview in gameContainer.subviews {
            subview.removeFromSuperview()
        }
    }
}

extension GameView: GameViewEventManager {
    func catchEvent(in object: UIView) {
        switch object {
        case switchModeButton:
            SIEventCenter.post(event: GameViewEvent.switchMode)
        default: break
        }
    }
}
