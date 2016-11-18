//
//  UIView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 30.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

extension UIView {
    func insert(subviews: [UIView], at index: Int?) {
        for object in subviews {
            object.translatesAutoresizingMaskIntoConstraints = false
            guard let someIndex = index else {
                self.addSubview(object)
                continue
            }
            self.insertSubview(object, at: someIndex)
        }
    }
    
    func constraintsWith(VisualFormat formats: [[String]], views: Dictionary<String, AnyObject>, metrics: Dictionary<String, CGFloat>? = nil, priority: Int? = nil, identifier: String? = nil) {
        for visualFormatConstraint in formats {
            self.constraintsWith(VisualFormat: visualFormatConstraint, views: views, metrics: metrics, priority: priority, identifier: identifier)
        }
    }
    
    func constraintsWith(VisualFormat formats: [String], views: Dictionary<String, AnyObject>, metrics: Dictionary<String, CGFloat>? = nil, priority: Int? = nil, identifier: String? = nil) {
        var constraints = [NSLayoutConstraint]()
        
        for visualConstraint in formats {
            let constraintsGroup = NSLayoutConstraint.constraints(withVisualFormat: visualConstraint, options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
            
            constraints.forEach({
                constraint in
                
                if priority != nil {
                    let floatPriority = UILayoutPriority(priority!)
                    constraint.priority = floatPriority
                }
                if identifier != nil {
                    constraint.identifier = identifier
                }
            })
            
            constraints.append(contentsOf: constraintsGroup)
        }
        
        self.addConstraints(constraints)
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
