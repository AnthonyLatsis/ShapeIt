//
//  EventCenter.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 16.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

protocol EventCenter: class{
    static func post(event: Any)
}
