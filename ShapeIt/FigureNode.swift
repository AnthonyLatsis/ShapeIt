//
//  FigureNode.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 21.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import SpriteKit
import UIKit

class FigureNode: SKShapeNode {
    let figure: Figure

    var edges: [StickNode] = []

    var orientationForCompleteFigure: [Orientation] = []

    init(size: CGSize, for level: Int = 0, mode: GameMode) {
        self.figure = Figure.figure(for: level, mode: mode)
        
        super.init()
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size)).cgPath
        
        setSK()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FigureNode {
    func setSK() {
        self.fillColor = .clear
        self.lineWidth = 0.0

        if figure.matrix.isNeutral() {
            // FIXME: not working for now
            setSK()
            return
        }
        for (i, row) in figure.verticalEdges.matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    let edge = StickNode(size: Style.stickSize, orientation: .vertical, fillColor: Style.lightPurple)
                    edges.append(edge)
                    self.addChild(edge)
                    edge.position = GameMap.positionOnScreenForVerticalEdge(indexes: (i, j), in: figure)
                }
            }
        }
        for (i, row) in figure.horizontalEdges.matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    let edge = StickNode(size: Style.stickSize, orientation: .horizontal, fillColor: Style.lightPurple)
                    edges.append(edge)
                    self.addChild(edge)
                    edge.position = GameMap.positionOnScreenForHorizontalEdge(indexes: (i, j), in: figure)
                }
            }
        }
        for edge in edges {
            orientationForCompleteFigure.append(edge.orientation)
        }
        
        disassembleFigure()
    }
}

extension FigureNode {
    func disassembleFigure() {
        var randomOrientations = Randomizer.randomArrayOf(size: orientationForCompleteFigure.count, spawn: Randomizer.randomOrientation)
        
        guard Array<Any>.equivalency(randomOrientations, orientationForCompleteFigure) <= GameMap.maximumEquivalencyFactor else {
            disassembleFigure()
            return
        }
        
        for (i, edge) in edges.enumerated() {
            if randomOrientations[i] == orientationForCompleteFigure[i] {
                edge.changeOrientation()
            }
        }
    }
    
    func isFigureComplete() -> Bool {
        guard edges.count == orientationForCompleteFigure.count else {
            fatalError()
        }
        for number in 0..<edges.count {
            if edges[number].orientation == orientationForCompleteFigure[number] {
                continue
            } else { return false }
        }
        return true
    }
    
    func findClosestEdge(to point: CGPoint) -> StickNode? {
        var edgeIndex = 0
        var minimumDistance: CGFloat = 0.0
        for (index, edge) in edges.enumerated() {
            let currentDistance: CGFloat = max(abs(edge.position.x - point.x), abs(edge.position.y - point.y))
            if minimumDistance == 0.0 {
                minimumDistance = currentDistance
            }
            if  currentDistance < minimumDistance {
                minimumDistance = currentDistance
                edgeIndex = index
            }
        }
        if minimumDistance > 20.0 {
            return nil
        } else {
            return edges[edgeIndex]
        }
    }
}
