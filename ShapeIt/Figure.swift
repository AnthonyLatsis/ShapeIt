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
            var matrixSize = (level / 5 + level / 10, level / 5)
            
            if level >= 40 {
                matrixSize = GameMap.maximumMatrixSize
            }
            if level % 5 == 0 {
                let randomNumber = Randomizer.randomInt(upperBound: 3)
                
                switch randomNumber {
                case 0:
                    return Figure(size: matrixSize, symmetryStyle: .central)
                case 1:
                    return Figure(size: matrixSize, symmetryStyle: .vertical)
                case 2:
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
