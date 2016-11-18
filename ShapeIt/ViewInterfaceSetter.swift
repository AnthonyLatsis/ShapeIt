//
//  ViewInterfaceSetter.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 31.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import Foundation

protocol ViewInterfaceSetter: class {
    func setUI()
    func setTargets()
    func setConstraints()
}

extension ViewInterfaceSetter {
    func setTargets()     {}
    func setConstraints() {}
}
