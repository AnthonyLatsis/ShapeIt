//
//  SIViewController.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 16.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class SIViewController: UIViewController {
    var active: Bool = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        SIEventCenter.add(vc: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        active = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        active = false
    }
    
    deinit {
        SIEventCenter.remove(vc: self)
    }
}
