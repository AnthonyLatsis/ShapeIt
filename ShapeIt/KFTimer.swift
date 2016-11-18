//
//  KFTimer.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 07.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import Foundation

class KFTimer: NSObject {
    var nsTimer: Timer!
    let handler: (() -> Void)
    
    init(timeInterval: Double, handler: @escaping (() -> Void)) {
        self.handler = handler
        
        super.init()
        
        nsTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(invokeHandler), userInfo: nil, repeats: false)
    }
    
    @objc private func invokeHandler() {
        handler()
        invalidate()
    }
    
    func invalidate() {
        nsTimer.invalidate()
    }
}
