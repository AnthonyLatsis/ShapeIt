//
//  CAMediaTimingFunction.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 31.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

extension CAMediaTimingFunction {
    static var Linear: CAMediaTimingFunction {
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    }
    static var EaseIn: CAMediaTimingFunction {
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    }
    static var EaseOut: CAMediaTimingFunction {
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    }
    static var EaseInEaseOut: CAMediaTimingFunction {
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    }
}
