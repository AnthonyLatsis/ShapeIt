//
//  StaticGameView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 30.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class StaticGameView: SIView {
    var figureView: FigureView
    
    var level: Int = 15
    
    var touchCounter: Int = 0

    init() {
        self.figureView = FigureView(for: level, mode: .regular)
        
        super.init(frame: Screen.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StaticGameView {
    override func setUI() {
        backgroundColor = Style.lightPurple
        
        self.insert(subviews: [figureView], at: 10)
        
        figureView.center = self.center
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapEdge(sender:)))
        figureView.addGestureRecognizer(gesture)
    }
}

extension StaticGameView {
    func didTapEdge(sender: UITapGestureRecognizer) {
        if figureView.isFigureComplete() && touchCounter != 0 {
            refreshFigure()
            return
        } 
        let tapX = sender.location(in: self).x
        let tapY = sender.location(in: self).y
        
        let optionalEdge = figureView.findClosestEdge(to: CGPoint(x: tapX, y: tapY))
        
        guard let edge = optionalEdge else {
            return
        }
        let rotation = Animations.rotation(angle: M_PI_2, duration: 0.2, repeats: 1.0, timingFunction: CAMediaTimingFunction.Linear, delegate: self)
        
        edge.layer.add(rotation, forKey: nil)
        
        edge.changeOrientation(rotate: false)
        
        touchCounter += 1
        // The event is passed on ONCE THE ANIMATION TERMINATES not to change colors during the rotation
    }
}

extension StaticGameView {
    func animateFigureCompletion() {
        backgroundColor = Style.blue
        for edge in figureView.edges {
            edge.changeLayersColor(to: Style.lightBlue)
            edge.backgroundColor = Style.blue
        }
        for node in figureView.nodes {
            node.changeLayerColor(to: Style.lightBlue)
            node.backgroundColor = Style.blue
            node.isHidden = false
        }
    }
    
    func refreshFigure() {
        level += 1
        
        figureView = FigureView(for: level, mode: .regular)
        
        touchCounter = 0
        
        for subview in subviews {
            subview.removeFromSuperview()
        }
        setUI()
    }
    
    func isFigureComplete() -> Bool {
        return figureView.isFigureComplete()
    }
}

extension StaticGameView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        SIEventCenter.post(event: StaticGameViewEvent.edgeTapped)
    }
}

