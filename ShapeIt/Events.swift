//
//  Events.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 16.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

enum StaticGameViewEvent {
    case edgeTapped
}

enum DynamicGameViewEvent {
    case gameOver
}

enum GameViewEvent {
    case switchMode
    
    func id() -> String { return GameViewEvent.id() }
    
    static func id() -> String { return "GameViewEvent" }
}


