//
//  Figure.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 05.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class Figure {
    let matrix: SIMatrix
    
    let verticalEdges: SIMatrix
    let horizontalEdges: SIMatrix
    
    let nodes: SIMatrix
    
    init(size: (Int, Int), symmetryStyle: SymmetryStyle? = nil) {
        if let style = symmetryStyle {
            matrix = SIMatrix(size: size, style: style)
        } else {
            matrix = SIMatrix(size: size)
        }
        verticalEdges = self.matrix.matrixForVerticalEdges(filtered: true)
        horizontalEdges = self.matrix.matrixForHorizontalEdges(filtered: true)
        
        nodes = self.matrix.matrixForNodes(verticalEdges: verticalEdges, horizontalEdges: horizontalEdges)
    }
    
    class func figure(for level: Int, mode: GameMode) -> Figure {
        switch mode {
        case .regular:
            var matrixSize = (0, 0)
            
            switch level {
            case 0..<5:
                matrixSize = (4, 3)
            case 5..<10:
                matrixSize = (6, 4)
            case 10..<15:
                matrixSize = (8, 5)
            case 15..<20:
                matrixSize = (10, 6)
            case 20..<25:
                matrixSize = (12, 7)
            default:
                matrixSize = (12, 7)
            }
   
            if level % 5 == 0 {
                let randomNumber = Randomizer.randomInt(upperBound: 2)
                
                switch randomNumber {
                case 0:
                    return Figure(size: matrixSize, symmetryStyle: .vertical)
                case 1:
                    return Figure(size: matrixSize, symmetryStyle: .horizontal)
                default: fatalError()
                }
            } else {
                return Figure(size: matrixSize)
            }
        case .dynamic:
            return Figure(size: (15, 7))
        }
    }
}

extension Figure: Equatable {
    final class func ==(lhs: Figure, rhs: Figure) -> Bool {
        return lhs.matrix == rhs.matrix
    }
}
