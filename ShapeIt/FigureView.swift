//
//  FigureView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 07.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class FigureView: UIView {
    let figure: Figure
    
    var edges: [EdgeView] = []
    var nodes: [NodeView] = []
    
    var orientationForCompleteFigure: [Orientation] = []
    
    init(for level: Int = 0, mode: GameMode) {
        self.figure = Figure.figure(for: level, mode: mode)
       
        super.init(frame: Screen.bounds)
    
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FigureView: ViewInterfaceSetter {
    func setUI() {
        self.backgroundColor = .clear
        
        if figure.matrix.isNeutral() {
            setUI()
            return
        }
        
        for (i, row) in figure.verticalEdges.matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    let edge = EdgeView(orientation: .vertical)
                    edges.append(edge)
                    insert(subviews: [edge], at: 10)
                    edge.center = GameMap.positionOnScreenForVerticalEdge(indexes: (i, j), in: figure)
                }
            }
        }
        for (i, row) in figure.horizontalEdges.matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    let edge = EdgeView(orientation: .horizontal)
                    edges.append(edge)
                    insert(subviews: [edge], at: 10)
                    edge.center = GameMap.positionOnScreenForHorizontalEdge(indexes: (i, j), in: figure)
                }
            }
        }
        for (i, row) in figure.nodes.matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    let nodeType = GameMap.nodeTypeFor(indexes: (i, j), in: figure)
                    let node = NodeView(type: nodeType)
                    self.nodes.append(node)
                    insert(subviews: [node], at: 10)
                    node.center = GameMap.positionOnScreenForNode(indexes: (i, j), in: figure)
                }
            }
        }
        for edge in edges {
            orientationForCompleteFigure.append(edge.orientation)
        }
        
        disassembleFigure()
        
        for node in self.nodes {
            bringSubview(toFront: node)
            node.isHidden = true
        }
    }
}

extension FigureView {
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
    
    func findClosestEdge(to point: CGPoint) -> EdgeView? {
        var edgeIndex = 0
        var minimumDistance: CGFloat = 0.0
        for (index, edge) in edges.enumerated() {
            let currentDistance: CGFloat = max(abs(edge.center.x - point.x), abs(edge.center.y - point.y))
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
