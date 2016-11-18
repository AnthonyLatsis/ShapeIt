//
//  Arrat.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 30.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit


extension Array {    
    static func equivalency<T: Equatable>(_ array1: [T], _ array2: [T]) -> CGFloat {
        guard array1.count == array2.count else {
            return 0.0
        }
        var matchCounter = 0
        
        for number in 0..<array1.count {
            if array1[number] == array2[number] {
                matchCounter += 1
            }
        }
        return CGFloat(matchCounter) / CGFloat(array1.count)
    }
    
    static func isSquare<T>(array: [[T]]) -> Bool {
        guard Array.isRectangular(array: array) else {
            return false
        }
        for element in array {
            if array.count == element.count {
                continue
            } else { return false }
        }
        return true
    }
    
    static func isRectangular<T>(array: [[T]]) -> Bool {
        var length = 0
        
        for element in array {
            if length == 0 {
                length = element.count
            } else if length == element.count {
                continue
            } else { return false }
        }
        return true
    }
    
    func indexIsStartOrEnd(_ index: Int) -> Bool {
        if index > 0 && index < self.count - 1 {
            return false
        }
        return true
    }
}
