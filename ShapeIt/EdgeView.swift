//
//  EdgeView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 31.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

enum Orientation {
    case vertical
    case horizontal
}

class EdgeView: UIView {
    var edgeBorderLayers: [CALayer] = []
    
    var orientation: Orientation
    
    init(orientation: Orientation) {
        self.orientation = orientation
        
        let frame = Style.verticalEdgeBounds
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EdgeView: ViewInterfaceSetter {
    func setUI() {
        backgroundColor = Style.purple
        let border1 = CALayer()
        let border2 = CALayer()
        
        border1.bounds = Style.verticalEdgeBorderBounds
        border2.bounds = Style.verticalEdgeBorderBounds
        border1.position = Style.positionForLeftBorderInVerticalEdge
        border2.position = Style.positionForRightBorderInVerticalEdge
        
        layer.addSublayer(border1)
        layer.addSublayer(border2)
        
        edgeBorderLayers.append(border1)
        edgeBorderLayers.append(border2)
        
        if orientation == .horizontal {
            self.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
        }
    }
}

extension EdgeView {
    func changeLayersColor(to color: UIColor) {
        for layer in edgeBorderLayers {
            layer.backgroundColor = color.cgColor
        }
    }
    
    func changeOrientation(rotate: Bool = true) {
        if orientation == .vertical {
            orientation = .horizontal
        } else {
            orientation = .vertical
        }
        if rotate {
            self.transform = self.transform.rotated(by: CGFloat(M_PI_2))
        }
    }
}
