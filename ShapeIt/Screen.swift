//
//  Screen.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 30.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

struct Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let center = CGPoint(x: width / 2.0, y: height / 2.0)
    static let bounds = UIScreen.main.bounds
}
