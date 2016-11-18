//
//  SIMatrix.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 30.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

enum SymmetryStyle {
    case central
    case vertical
    case horizontal
}

enum SIMatrixType {
    case map
    case edge
}

class SIMatrix: Matrix<Bool> {
    let type: SIMatrixType

    init(matrix: SIMatrix) {
        self.type = matrix.type
        
        super.init(matrix: matrix)
    }
    
    init(size: (Int, Int), type: SIMatrixType = .map, style: SymmetryStyle? = nil) {
        self.type = type
    
        super.init(size: size, randomizer: Randomizer.randomBool, neutral: false)
        
        let centerIndex = size.1 / 2
        
        guard let style = style else {
            return
        }
        
        switch style {
        case .central:
            for (i, _) in matrix.enumerated() {
                for j in 0..<centerIndex {
                    matrix[size.0 - 1 - i][size.1 - 1 - j] = matrix[i][j]
                }
            }
        case .horizontal:
            for (i, _) in matrix.enumerated() {
                for j in 0..<centerIndex {
                    matrix[i][size.1 - 1 - j] = matrix[i][j]
                }
            }
        case .vertical:
            for (i, _) in matrix.enumerated() {
                for j in 0..<centerIndex {
                    matrix[size.0 - 1 - i][j] = matrix[i][j]
                }
            }
        }
    }
}

extension SIMatrix {
    func matrixForHorizontalEdges(filtered: Bool = false) -> SIMatrix {
        guard type == .map else {
            fatalError()
        }
        let result = SIMatrix(size: (size.0 + 1, size.1))
        result.neutralize()
        
        for (i, row) in self.matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    result[i][j] = true
                    result[i + 1][j] = true
                }
            }
        }
        if filtered {
            filterHorizontalEdges(matrix: &result.matrix)
        }
        return result
    }
    
    func matrixForVerticalEdges(filtered: Bool = false) -> SIMatrix {
        guard type == .map else {
            fatalError()
        }
        let result = SIMatrix(size: (size.0, size.1 + 1))
        result.neutralize()
        
        for (i, row) in matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    result[i][j] = true
                    result[i][j + 1] = true
                }
            }
        }
        if filtered {
            filterVerticalEdges(matrix: &result.matrix)
        }
        return result
    }
    fileprivate func filterVerticalEdges(matrix: inout [[Bool]]) -> Void {
        let verticalEdges = matrixForVerticalEdges()
        
        for (i, row) in verticalEdges.matrix.enumerated() {
            for (j, _) in row.enumerated() {
                if !row.indexIsStartOrEnd(j) && (verticalEdges[i][j - 1] && verticalEdges[i][j + 1]) && self.matrix[i][j] && self.matrix[i][j - 1] {
                    matrix[i][j] = false
                }
            }
        }
    }
    
    fileprivate func filterHorizontalEdges(matrix: inout [[Bool]]) -> Void {
        let horizontalEdges = matrixForHorizontalEdges()
        
        for (i, row) in horizontalEdges.matrix.enumerated() {
            for (j, _) in row.enumerated() {
                if !horizontalEdges.matrix.indexIsStartOrEnd(i) && (horizontalEdges[i + 1][j] && horizontalEdges[i - 1][j]) && self.matrix[i][j] && self.matrix[i - 1][j] {
                    matrix[i][j] = false
                }
            }
        }
    }
    
    func matrixForNodes(verticalEdges: SIMatrix, horizontalEdges: SIMatrix) -> SIMatrix {
        guard type == .map else {
            fatalError()
        }
        let result = SIMatrix(size: (size.0 + 1, size.1 + 1), type: .edge)
        result.neutralize()
        
        for (i, row) in verticalEdges.matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    result[i][j] = true
                    result[i + 1][j] = true
                }
            }
        }
        for (i, row) in horizontalEdges.matrix.enumerated() {
            for (j, element) in row.enumerated() {
                if element {
                    result[i][j] = true
                    result[i][j + 1] = true
                }
            }
        }
        return result
    }
}

