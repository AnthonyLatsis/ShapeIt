//
//  Matrix.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 16.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import Foundation


class Matrix<T: Equatable> {
    var matrix: [[T]]
    
    var size: (Int, Int)
    
    var randomizer: (() -> T)? = nil
    
    var neutralElement: T? = nil
    
    init(size: (Int, Int), randomizer: @escaping (() -> T), neutral: T? = nil) {
        self.size = size
        self.randomizer = randomizer
        self.neutralElement = neutral

        matrix = (0..<size.0).map{_ in (0..<size.1).map{_ in randomizer()}}
    }
    
    init?(array: [[T]], neutral: T? = nil) {
        guard Array<Any>.isRectangular(array: array) else {
            return nil
        }
        self.neutralElement = neutral
        self.matrix = array
        self.size = (array.count, array[0].count)
    }
    
    init(matrix: Matrix<T>) {
        self.matrix = matrix.matrix
        self.size = matrix.size
        self.randomizer = matrix.randomizer
        self.neutralElement = matrix.neutralElement
    }
}

extension Matrix {
    subscript (i: Int) -> [T] {
        get {
            return matrix[i]
        }
        set(value) {
            matrix[i] = value
        }
    }
    
    internal func neutralize() {
        guard let neutralizer = neutralElement else {
            return
        }
        for (i, row) in matrix.enumerated() {
            for (j, _) in row.enumerated() {
                matrix[i][j] = neutralizer
            }
        }
    }
    
    func isNeutral() -> Bool {
        for row in matrix {
            for element in row {
                if element != neutralElement {
                    return false
                }
            }
        }
        return true
    }
}

extension Matrix: Equatable {
    final class func ==<U: Equatable>(lhs: Matrix<U>, rhs: Matrix<U>) -> Bool {
        if lhs.size != rhs.size {
            return false
        }
        for i in 0..<lhs.size.0 {
            for j in 0..<lhs.size.1 {
                if lhs[i][j] != rhs[i][j] {
                    return false
                }
            }
        }
        return true
    }
}
