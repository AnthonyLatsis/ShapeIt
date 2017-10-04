//
//  DynamicGameScene.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 22.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//


import UIKit
import GameKit

struct DynamicGameConstants {
    fileprivate static let startPoint  = CGPoint(x: 0, y: 2 * Screen.center.y)
    fileprivate static let mediumPoint = CGPoint.zero
    fileprivate static let endPoint    = CGPoint(x: 0, y: -2 * Screen.center.y)
    
    fileprivate static let pointToPointDuration: Double = 30.0
}

class DynamicGameScene: SKScene {
    var figureNodeQueue = Queue<FigureNode>()

    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = Style.lightPurple
        
        addNewFigure(start: true)
    }

}

extension DynamicGameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(t) }
    }
}

extension DynamicGameScene {
    func touchDown(_ touch : UITouch) {
        for figureNode in figureNodeQueue.queue {
            if figureNode.frame.contains(touch.location(in: self)) {
                let optionalEdge = figureNode.findClosestEdge(to: touch.location(in: figureNode))
                print(touch.location(in: figureNode))
                
                guard let edge = optionalEdge else {
                    return
                }
                edge.run(SKAction.rotate(byAngle: .pi / 2, duration: 0.15))
                edge.changeOrientation(rotate: false)
            }
        }
    }
}

extension DynamicGameScene {
    func addNewFigure(start: Bool = false) {
        let figureNode = FigureNode(size: Screen.bounds.size, mode: .dynamic)
        
        if start { figureNode.position = CGPoint(x: 0, y: Screen.center.y) }
        else     { figureNode.position = DynamicGameConstants.startPoint }
        
        figureNodeQueue.enqueue(element: figureNode)
        
        self.addChild(figureNode)
        
        var duration = DynamicGameConstants.pointToPointDuration
        
        if start { duration /= 2 }
        
        figureNode.run(SKAction.move(to: DynamicGameConstants.mediumPoint, duration: duration)) {
            self.animationCompletion()
        }
    }
    
    //    func clear(restart: Bool) {
    //        while figureViewQueue.count > 0 {
    //            figureViewQueue.dequeueAndPop().removeFromSuperview()
    //        }
    //        if restart {
    //            setUI()
    //        }
    //    }
}

extension DynamicGameScene {
    func animationCompletion() {
        let figureNode = figureNodeQueue.getLast()
        figureNode.run(SKAction.move(to: DynamicGameConstants.endPoint, duration: DynamicGameConstants.pointToPointDuration)) {
            figureNode.run(SKAction.removeFromParent())
        }
        addNewFigure()
    }
}

//
//extension DynamicGameView: AnimatedFigureViewDelegate {
//    func didMove(figureView: AnimatedFigureView) {
//        for (i, edge) in figureView.edges.enumerated() {
//            let currentCenterY = figureView.center.y + positionDeltaFor(figureView: figureView)
//            
//            let edgeY = edge.center.y
//            
//            guard currentCenterY > Screen.center.y else {
//                return
//            }
//            if edgeY > Screen.height - ((currentCenterY + Screen.height / 2) - Screen.height) {
//                if edge.orientation != figureView.orientationForCompleteFigure[i] {
//                    SIEventCenter.post(event: DynamicGameViewEvent.gameOver)
//                }
//            }
//        }
//    }
//}
