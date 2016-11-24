//
//  StickNode.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 21.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import SpriteKit
import UIKit

enum Orientation {
    case vertical
    case horizontal
}

class StickNode: SKShapeNode {
    var orientation: Orientation
    
    init(size: CGSize, orientation: Orientation, fillColor: UIColor) {
        self.orientation = orientation
        
        super.init()
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2), size: size)).cgPath
        self.fillColor = fillColor

        setSK()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StickNode {
    func setSK() {
        self.lineWidth = 0.0
        
        if orientation == .horizontal {
            self.run(SKAction.rotate(byAngle: CGFloat(M_PI_2), duration: 0.0))
        }
    }
}

extension StickNode {
    func changeOrientation(rotate: Bool = true) {
        if orientation == .vertical {
            orientation = .horizontal
        } else {
            orientation = .vertical
        }
        if rotate {
            self.run(SKAction.rotate(byAngle: CGFloat(M_PI_2), duration: 0.0))
        }
    }
}
