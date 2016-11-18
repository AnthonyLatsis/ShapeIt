//
//  SIView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 17.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

class SIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTargets()
        setUI()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SIView: ViewInterfaceSetter {
    func setTargets() {}
    func setUI() {}
    func setConstraints() {}
}
