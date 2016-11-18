//
//  AnimatedFigureView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 17.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit
import Foundation

class AnimatedFigureView: FigureView {
    var delegate: AnimatedFigureViewDelegate?
    
    fileprivate var timer: Timer?
    
    let startDate: NSDate
    
    init(for level: Int = 0, mode: GameMode, delegate: AnimatedFigureViewDelegate? = nil, anim: CAAnimation) {
        startDate = NSDate()
        self.delegate = delegate
        
        super.init(for: level, mode: mode)
        
        add(animation: anim)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        timer?.invalidate()
        timer = nil
    }
}

extension AnimatedFigureView {
    fileprivate func add(animation: CAAnimation) {
        layer.add(animation, forKey: nil)

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in self.delegate?.didMove(figureView: self)})
    }
}
