//
//  Style.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 31.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class Style {
    static let bezel = CGFloat(10.0)
    
    static let periwinkle = UIColor(red: 100.0/255.0, green: 113.0/255.0, blue: 190.0/255.0, alpha: 1.0)
    
    static let purple = UIColor(red: 90.0/255.0, green: 90.0/255.0, blue: 158.0/255.0, alpha: 1.0)
    static let lightPurple = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 225.0/255.0, alpha: 1.0)
    
    static let lightBlue = UIColor(red: 42.0/255.0, green: 73.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    static let blue = UIColor(red: 3.0/255.0, green: 15.0/255.0, blue: 72.0/255.0, alpha: 1.0)
    
    
    static let edgeBorderWidth = Style.bezel / 5
    
    static let cellSize: CGFloat = Screen.height / 16
    
    static let edgeViewSize: CGFloat = Style.cellSize + Style.bezel
    
    static let cellBounds: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(size: Style.edgeViewSize))
    
    static let verticalEdgeBounds: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: Style.bezel, height: Style.edgeViewSize))
}

// Nodes
extension Style {
    static let nodeViewBounds: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(size: Style.bezel))
    
    static let nodeSquareEdgeBounds: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(size: Style.edgeBorderWidth))
    
    static let nodeVerticalRectEdgeBounds: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: Style.edgeBorderWidth, height: Style.bezel))
    
    static let nodeHorizontalRectEdgeBounds: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: Style.bezel, height: Style.edgeBorderWidth))
}

// Edge Borders
extension Style {
    static let verticalEdgeBorderBounds: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: Style.edgeBorderWidth, height: Style.edgeViewSize - Style.bezel * 2))
    
    static let positionForLeftBorderInVerticalEdge: CGPoint = CGPoint(x: Style.edgeBorderWidth / 2, y: Style.edgeViewSize / 2)

    static let positionForRightBorderInVerticalEdge: CGPoint = CGPoint(x: Style.bezel - Style.edgeBorderWidth / 2, y: Style.edgeViewSize / 2)

}
