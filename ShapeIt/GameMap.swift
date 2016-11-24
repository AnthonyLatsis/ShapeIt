//
//  GameMap.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 30.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class GameMap: NSObject {
    static let maximumMatrixSize: (Int, Int) = (11, 7)
    static let maximumEquivalencyFactor: CGFloat = CGFloat(0.5)
    
    class func figureLeftBound(_ matrixWidth: Int) -> CGFloat {
        return (Screen.center.x - (CGFloat(matrixWidth) * Style.cellSize) / 2)
    }
    
    class func figureTopBound(_ matrixHeight: Int) -> CGFloat {
        return (Screen.center.y - (CGFloat(matrixHeight) * Style.cellSize) / 2)
    }

    class func positionOnScreenForHorizontalEdge(indexes: (Int, Int), in figure: Figure) -> CGPoint {
        let matrixSize = figure.matrix.size
        
        let x = GameMap.figureLeftBound(matrixSize.1) + (CGFloat((indexes.1 * 2 + 1)) / 2.0) * Style.cellSize
        
        let y = GameMap.figureTopBound(matrixSize.0) + CGFloat(indexes.0) * Style.cellSize
        
        return CGPoint(x: x, y: y)
    }

    class func positionOnScreenForVerticalEdge(indexes: (Int, Int), in figure: Figure) -> CGPoint {
        let matrixSize = figure.matrix.size
        
        let x = GameMap.figureLeftBound(matrixSize.1) + CGFloat(indexes.1) * Style.cellSize
        
        let y = GameMap.figureTopBound(matrixSize.0) + (CGFloat((indexes.0 * 2 + 1)) / 2.0) * Style.cellSize

        return CGPoint(x: x, y: y)
    }
    
    class func positionOnScreenForNode(indexes: (Int, Int), in figure: Figure) -> CGPoint {
        let matrixSize = figure.matrix.size

        let x = GameMap.figureLeftBound(matrixSize.1) + CGFloat(indexes.1) * Style.cellSize
        
        let y = GameMap.figureTopBound(matrixSize.0) + CGFloat(indexes.0) * Style.cellSize
        
        return CGPoint(x: x, y: y)
    }
    
//    class func nodeTypeFor(indexes: (Int, Int), in figure: Figure) -> NodeType {
//        let verticalEdges = figure.verticalEdges
//        let horizontalEdges = figure.horizontalEdges
//        
//        var edgesAround: (topEdge: Bool, bottomEdge: Bool, leftEdge: Bool, rightEdge: Bool) = (false, false, false, false)
//        
//        if (indexes.0 - 1 >= 0) && verticalEdges[indexes.0 - 1][indexes.1] {
//            edgesAround.topEdge = true
//        }
//        
//        if (indexes.1 <= (horizontalEdges.size.1 - 1)) && horizontalEdges[indexes.0][indexes.1] {
//            edgesAround.rightEdge = true
//        }
//        
//        if (indexes.0 <= verticalEdges.size.0 - 1) && verticalEdges[indexes.0][indexes.1] {
//            edgesAround.bottomEdge = true
//        }
//        
//        if (indexes.1 - 1 >= 0) && horizontalEdges[indexes.0][indexes.1 - 1] {
//            edgesAround.leftEdge = true
//        }
//
//        if edgesAround == (true, true, true, true) { return .inside }
//        if edgesAround == (true, true, true, false) { return .rightBranch }
//        if edgesAround == (true, true, false, true) { return .leftBranch }
//        if edgesAround == (true, false, true, true) { return .bottomBranch }
//        if edgesAround == (false, true, true, true) { return .topBranch }
//        if edgesAround == (false, true, false, true) { return .topLeft }
//        if edgesAround == (false, true, true, false) { return .topRight }
//        if edgesAround == (true, false, false, true) { return .bottomLeft }
//        if edgesAround == (true, false, true, false) { return .bottomRight }
//        if edgesAround == (true, true, false, false) { return .verticalStraight }
//        if edgesAround == (false, false, true, true) { return .horizontalStraight }
//        
//        return .inside
//    }
}
