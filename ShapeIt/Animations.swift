//
//  Animations.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 31.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class Animations {
    class func opacityAnimation(duration: CFTimeInterval, points: [CGFloat], timingFuntion: CAMediaTimingFunction, delegate: CAAnimationDelegate? = nil) -> CAKeyframeAnimation {
        let anim = CAKeyframeAnimation(keyPath: "opacity")
        anim.values = points
        anim.duration = duration
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        anim.timingFunction = timingFuntion
        anim.delegate = delegate
        
        return anim
    }
    
    class func scaleAnimation(duration: CFTimeInterval, points: [CGFloat], timingFunction: CAMediaTimingFunction, delegate: CAAnimationDelegate? = nil) -> CAKeyframeAnimation {
        var transformations: [NSValue] = []
        let id = CATransform3DIdentity
        
        for point in points {
            transformations.append(NSValue.init(caTransform3D: CATransform3DScale(id, point, point, 0.0)))
        }
        
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = transformations
        anim.duration = duration
        anim.timingFunction = timingFunction
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        anim.delegate = delegate
        
        return anim
    }
    
    class func positionAnimation(duration: CFTimeInterval, points: [CGPoint], timingFunction: CAMediaTimingFunction, delegate: CAAnimationDelegate? = nil) -> CAKeyframeAnimation {
        var transformations: [NSValue] = []
        
        for point in points {
            transformations.append(NSValue(cgPoint: point))
        }
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.values = transformations
        anim.duration = duration
        anim.timingFunction = timingFunction
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        anim.delegate = delegate
        
        return anim
        
    }
    
    class func scaleAnimation(duration: CFTimeInterval, to: CGFloat, timingFunction: CAMediaTimingFunction, delegate: CAAnimationDelegate? = nil) -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: "transform")
        let id = CATransform3DIdentity
        
        scale.duration = duration
        scale.toValue = NSValue.init(caTransform3D: CATransform3DScale(id, to, to, 0.0))
        scale.timingFunction = timingFunction
        scale.fillMode = kCAFillModeForwards
        scale.isRemovedOnCompletion = false
        
        return scale
    }
    
    class func rotation(angle: Double, duration: CFTimeInterval, repeats: Float, timingFunction: CAMediaTimingFunction, delegate: CAAnimationDelegate? = nil) -> CABasicAnimation {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.byValue = CGFloat(angle)
        rotation.duration = duration
        rotation.timingFunction = timingFunction
        rotation.repeatCount = repeats
        rotation.delegate = delegate
        rotation.isRemovedOnCompletion = false
        rotation.fillMode = kCAFillModeForwards
        
        return rotation
    }
    
    class func groupAnimation(animations: [CAAnimation], repeats: CGFloat = 1.0, delegate: CAAnimationDelegate? = nil) -> CAAnimationGroup {
        let group = CAAnimationGroup()
        group.animations = animations
        group.repeatCount = Float(repeats)
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        group.delegate = delegate
        
        return group
    }
    
    class func moveToPointAnimation(fromPoint: CGPoint?, toPoint: CGPoint, duration: CFTimeInterval, timingFunc: String, delegate: CAAnimationDelegate? = nil) -> CABasicAnimation {
        let moveAnim = CABasicAnimation(keyPath: "position")
        moveAnim.toValue = NSValue(cgPoint: toPoint)
        moveAnim.duration = duration
        moveAnim.fillMode = kCAFillModeForwards
        moveAnim.isRemovedOnCompletion = false
        moveAnim.timingFunction = CAMediaTimingFunction(name: timingFunc)
        moveAnim.delegate = delegate
        
        if fromPoint != nil {
            moveAnim.fromValue = NSValue(cgPoint: fromPoint!)
        }
        
        return moveAnim
    }
}
