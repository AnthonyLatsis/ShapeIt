//
//  NodeView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 01.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//


//       . . .__________________
//       . . .------------||---||
//                        ||   || <-- This is a Node
//       . . .____________||___||     Nodes can be different. Namely this one
//       . . .------------||---||     is an EDGE Node (case rightTop)
//                        ||   ||
//                        ||   ||
//                        ||   ||
//                        ||   ||
//                        .     .
//                        .     .
//                        .     .


// When a figure is complete, it lights up with its borders. At this point, the edgeViews intersect
// and there isn't a decent way to make the border of the figure look nice. What happens can be seen 
// in the picture above in the Node. To look as it should, the same picture must look like this:

//       . . .__________________
//       . . .-----------------||
//                             || <-- To make it look like this the class below exists.
//       . . ._____________    ||   the  NodeView itself HERE looks like this:
//       . . .------------||   ||                                                   |
//                        ||   ||              _______                              |
//                        ||   ||              |-----|| <---------------------------
//                        ||   ||              |_    ||
//                        ||   ||              |_|___||
//                        .     .
//                        .     .
//                        .     .

// If you look into all the kinds of Nodes, you will notice we need only 2 types of layers to
// make them. small SQUARE layers and RECTANGLE ones. the SQUARE ones will be called
// NodeSquareEdge.

// In the Node above we need 1 SQUARE and 2 RECTANGLE layers.


import UIKit

enum NodeType {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case inside
    case leftBranch
    case rightBranch
    case bottomBranch
    case topBranch
    case verticalStraight
    case horizontalStraight
    
    func isEdge() -> Bool {
        switch self {
        case .topLeft, .topRight, .bottomLeft, .bottomRight:
            return true
        default: return false
        }
    }
}

class NodeView: UIView {
    let type: NodeType
    
    var layers: [CALayer] = []
    
    init(type: NodeType) {
        self.type = type
        
        let frame = Style.nodeViewBounds
        
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NodeView: ViewInterfaceSetter {
    func setUI() {
        backgroundColor = Style.purple
        
        if type == .inside {
            let sublayers = (0...3).map{_ in CALayer()}
            
            for layer in sublayers {
                layer.bounds = Style.nodeSquareEdgeBounds
                layers.append(layer)
            }
            sublayers[0].position = CGPoint(x: Style.edgeBorderWidth / 2, y: Style.edgeBorderWidth / 2)
            sublayers[1].position = CGPoint(x: Style.bezel - Style.edgeBorderWidth / 2, y: Style.edgeBorderWidth / 2)
            sublayers[2].position = CGPoint(x: Style.bezel - Style.edgeBorderWidth / 2, y: Style.bezel - Style.edgeBorderWidth / 2)
            sublayers[3].position = CGPoint(x: Style.edgeBorderWidth / 2, y: Style.bezel - Style.edgeBorderWidth / 2)
        }
        if type == .leftBranch || type == .rightBranch || type == .topBranch || type == .bottomBranch {
            let sublayers = (0..<3).map{_ in CALayer()}
            
            for layer in sublayers {
                layers.append(layer)
            }
            sublayers[0].bounds = Style.nodeSquareEdgeBounds
            sublayers[1].bounds = Style.nodeSquareEdgeBounds
            sublayers[2].bounds = Style.nodeVerticalRectEdgeBounds
            
            sublayers[0].position = CGPoint(x: Style.edgeBorderWidth / 2, y: Style.edgeBorderWidth / 2)
            sublayers[1].position = CGPoint(x: Style.edgeBorderWidth / 2, y: Style.bezel - Style.edgeBorderWidth / 2)
            sublayers[2].position = CGPoint(x: Style.bezel - Style.edgeBorderWidth / 2, y: Style.bezel / 2)
            
            switch type {
            case .leftBranch:
                self.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
            case .rightBranch:
                self.transform = CGAffineTransform.init(rotationAngle: 0.0)
            case .topBranch:
                self.transform = CGAffineTransform.init(rotationAngle: -(CGFloat)(M_PI_2))
            case .bottomBranch:
                self.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
            default: break
            }
        }
        if (type == .topLeft || type == .topRight || type == .bottomRight || type == .bottomLeft) {
            let sublayers = (0..<3).map{_ in CALayer()}
            
            for layer in sublayers {
                layers.append(layer)
            }
            sublayers[0].bounds = Style.nodeSquareEdgeBounds
            sublayers[1].bounds = Style.nodeVerticalRectEdgeBounds
            sublayers[2].bounds = Style.nodeHorizontalRectEdgeBounds
            
            sublayers[0].position = CGPoint(x: Style.edgeBorderWidth / 2, y: Style.edgeBorderWidth / 2)
            sublayers[1].position = CGPoint(x: Style.bezel - Style.edgeBorderWidth / 2, y: Style.bezel / 2)
            sublayers[2].position = CGPoint(x: Style.bezel / 2, y: Style.bezel - Style.edgeBorderWidth / 2)
            
            switch type {
            case .topLeft:
                self.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
            case .topRight:
                self.transform = CGAffineTransform.init(rotationAngle: -CGFloat(M_PI_2))
            case .bottomLeft:
                self.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
            case .bottomRight:
                self.transform = CGAffineTransform.init(rotationAngle: 0.0)
            default: break
            }
        }
        if (type == .verticalStraight || type == .horizontalStraight) {
            let sublayers = (0..<2).map{_ in CALayer()}
            
            for layer in sublayers {
                layers.append(layer)
            }
            sublayers[0].bounds = Style.nodeVerticalRectEdgeBounds
            sublayers[1].bounds = Style.nodeVerticalRectEdgeBounds
            
            sublayers[0].position = CGPoint(x: Style.edgeBorderWidth / 2, y: Style.bezel / 2)
            sublayers[1].position = CGPoint(x: Style.bezel - Style.edgeBorderWidth / 2, y: Style.bezel / 2)
            
            switch type {
            case .horizontalStraight:
                self.transform = CGAffineTransform.init(rotationAngle:  CGFloat(M_PI_2))
            case .verticalStraight:
                self.transform = CGAffineTransform.init(rotationAngle: 0.0)
            default: break
            }
        }
        for layer in layers {
            layer.backgroundColor = UIColor.cyan.cgColor
            self.layer.addSublayer(layer)
        }
    }
    
    func changeLayerColor(to color: UIColor) {
        for layer in layers {
            layer.backgroundColor = color.cgColor
        }
    }
}
