//
//  Randomizer.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 30.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import GameKit

final class Randomizer {
    class func randomInt(upperBound bound: Int) -> Int {
        return GKRandomSource.sharedRandom().nextInt(upperBound: bound)
    }
    
    class func randomBool() -> Bool {
        let randomNumber = randomInt(upperBound: 1000)
        return randomNumber % 2 == 0
    }
    
    class func randomOrientation() -> Orientation {
        let bool = Randomizer.randomBool()
        
        if bool {
            return .vertical
        } else {
            return .horizontal
        }
    }
    
    /**
    An array of type [T] with random elements
     
    * **size** - the size of the array
    * **spawn** - the function with which to spawn a random element for the array
    */
    class func randomArrayOf<T>(size: Int, spawn: () -> T) -> [T] {
        var array: [T] = []
        
        for _ in 0..<size {
            array.append(spawn())
        }
        // FIX IT: WTF this function works well for
        return array
    }
}
