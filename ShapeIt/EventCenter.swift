//
//  EventCenter.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 16.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class EventCenter {
    fileprivate static var dict: [UIViewController] = []
    
    class func post(event: Any) {}
    
    class func add(vc: UIViewController) {
        dict.append(vc)
    }
    
    class func remove(vc: UIViewController) {
        dict.remove(at: findIndexFor(vc: vc))
    }
}

extension EventCenter {
    class func findIndexFor(vc: UIViewController) -> Int {
        for (i, viewController) in dict.enumerated() {
            if viewController == vc {
                return i
            }
        }
        fatalError()
    }
    
    class func activeVCs() -> [UIViewController] {
        var vcs: [UIViewController] = []
        for vc in dict {
            if (vc.isViewLoaded && vc.view.window != nil) || vc.view.superview != nil {
                vcs.append(vc)
            }
        }
        return vcs
    }
    
    class func getManager<X, Y>(_: X.Type, _: Y.Type) -> Y {
        for vc in activeVCs() {
            if vc is X {
                return (vc as! Y)
            }
        }
        fatalError()
    }
}
