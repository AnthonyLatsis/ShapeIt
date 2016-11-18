//
//  Queue.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 09.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import Foundation

class Queue<T> {
    fileprivate var queue: [T] = []
    
    var count: Int {
        return queue.count
    }
    
    func enqueue(element: T) {
        queue.append(element)
    }
    
    func dequeue() {
        guard queue.count > 0 else {
            return
        }
        queue.remove(at: 0)
    }
    
    func dequeueAndPop() -> T {
        let element = queue[0]
        
        queue.remove(at: 0)
        
        return element
    }
    
    func getFirst() -> T {
        return queue[0]
    }
    
    func getLast() -> T {
        return queue[queue.count - 1]
    }
    
    func clear() {
        queue = []
    }
}
