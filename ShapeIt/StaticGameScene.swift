//
//  StaticGameScene.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 21.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import SpriteKit
import GameplayKit

class StaticGameScene: SKScene {
    var figureNode: FigureNode
    
    var labelNode = SKLabelNode()
    
    var level: Int = 1
    
    override init(size: CGSize) {
        self.figureNode = FigureNode(size: size, for: level, mode: .regular)

        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        labelNode.fontSize = 65.0
        labelNode.fontColor = Style.purple
        labelNode.position = Screen.center
        labelNode.fontName = "bubbleboddy-Fat"
        
        addNewFigure(remove: false)
    }
}

extension StaticGameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension StaticGameScene {
    func touchDown(atPoint pos : CGPoint) {
        if figureNode.isFigureComplete() {
            addNewFigure()
            return
        }
        let optionalEdge = figureNode.findClosestEdge(to: pos)
        
        guard let edge = optionalEdge else {
            return
        }
        edge.run(SKAction.rotate(byAngle: .pi / 2, duration: 0.15)) {
            if self.figureNode.isFigureComplete() {
                self.animateFigureCompletion()
            }
        }
        edge.changeOrientation(rotate: false)
    }
}

extension StaticGameScene {
    func addNewFigure(remove: Bool = true) {
        backgroundColor = Style.lightPurple
        level += 1
        
        labelNode.text = "\(level)"

        if remove { figureNode.run(SKAction.removeFromParent()) }
        
        figureNode = FigureNode(size: self.size, for: level, mode: .regular)
        figureNode.position = self.position
        
        self.addChild(labelNode)
        
        labelNode.run(actionForLevelLabel()) {
            self.addChild(self.figureNode)
            
            self.showFigure()
        }
        if level >= 25 {
            rotateRandomEdge()
        }
    }
}

extension StaticGameScene {
    func animateFigureCompletion() {
        for edge in figureNode.edges {
            edge.removeAllActions()
        }
        self.run(backgroundColorTransition(from: backgroundColor, to: Style.blue, duration: 0.5))
        for edge in figureNode.edges {
            edge.run(fillColorTransition(from: edge.fillColor, to: Style.lightBlue, duration: 0.5))
        }
    }
    
    func rotateRandomEdge() {
        let randomIndex = Randomizer.randomInt(upperBound: figureNode.edges.count)
        
        figureNode.edges[randomIndex].run(SKAction.sequence([
            SKAction.wait(forDuration: 5.25 - Double(level) / 20.0),
            SKAction.rotate(byAngle: .pi / 2, duration: 0.15)
            ])) {
                self.figureNode.edges[randomIndex].changeOrientation(rotate: false)
            self.rotateRandomEdge()
        }
    }
    
    func showFigure() {
        let edgesCount = self.figureNode.edges.count
        
        for i in 0..<edgesCount {
            var rotationAngle: CGFloat = 0.0
            var count: Int = 0
            
            if i % 2 == 0 { rotationAngle = .pi }
            else          { rotationAngle = -.pi }
            
            if i < (edgesCount / 2) { count = i }
            else { count = (edgesCount - 1) - (i - edgesCount / 2)}
            
            self.figureNode.edges[count].run(SKAction.sequence([
                SKAction.wait(forDuration: 2.0 * (Double(i) / Double(edgesCount))),
                SKAction.group([
                    SKAction.rotate(byAngle: rotationAngle, duration: 0.1),
                    self.fillColorTransition(from: Style.lightPurple, to: Style.purple, duration: 2.0),
                ])
            ]))
            
        }
    }
    
    func actionForLevelLabel() -> SKAction {
        return SKAction.sequence([
            SKAction.scale(by: 0.5, duration: 0),
            SKAction.group([
                SKAction.scale(by: 2, duration: 2.5),
                SKAction.sequence([
                    SKAction.wait(forDuration: 1.8),
                    SKAction.fadeOut(withDuration: 0.7)
                    ])
                ]),
            SKAction.fadeIn(withDuration: 0),
            SKAction.removeFromParent()
        ])
    }
    
    func instantColor(from: UIColor, to: UIColor, duration: Double, elapsed: CGFloat) -> UIColor {
        var frgba: [CGFloat] = [0.0, 0.0, 0.0, 0.0]
        var trgba: [CGFloat] = [0.0, 0.0, 0.0, 0.0]
        
        from.getRed(&frgba[0], green: &frgba[1], blue: &frgba[2], alpha: &frgba[3])
        to.getRed(&trgba[0], green: &trgba[1], blue: &trgba[2], alpha: &trgba[3])
        
        let fraction = CGFloat(elapsed / CGFloat(duration))
            
        return UIColor(red:   frgba[0] + fraction * (trgba[0] - frgba[0]),
                                 green: frgba[1] + fraction * (trgba[1] - frgba[1]),
                                 blue:  frgba[2] + fraction * (trgba[2] - frgba[2]),
                                 alpha: frgba[3] + fraction * (trgba[3] - frgba[3]))
    }
    
    func backgroundColorTransition(from: UIColor, to: UIColor, duration: Double) -> SKAction {
        return SKAction.customAction(withDuration: duration) {
            (node, elapsed) in
            let instant = self.instantColor(from: from, to: to, duration: duration, elapsed: elapsed)
            (node as! SKScene).backgroundColor = instant
        }
    }
    
    func fillColorTransition(from: UIColor, to: UIColor, duration: Double) -> SKAction {
        return SKAction.customAction(withDuration: duration) {
            (node, elapsed) in
            let instant = self.instantColor(from: from, to: to, duration: duration, elapsed: elapsed)
            (node as! SKShapeNode).fillColor = instant
        }
    }
}
