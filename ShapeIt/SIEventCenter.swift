//
//  SIEventCenter.swift
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
}

final class SIEventCenter: EventCenter {
    static var dict: [SIViewController] = []
    
    override class func post(event: Any) {
        switch event {
        case is DynamicGameViewEvent:
            route(event: event as! DynamicGameViewEvent)
        case is StaticGameViewEvent:
            route(event: event as! StaticGameViewEvent)
        case is GameViewEvent:
            route(event: event as! GameViewEvent)
        default: break
        }
    }
}

// MARK: Event Routers
extension SIEventCenter {
    class func route(event: DynamicGameViewEvent) {
//        switch event {
//        case .gameOver:
//            getManager(DynamicGameViewController.self, DynamicGameViewEventManager.self).handle(event: event)
//        }
    }
    
    class func route(event: StaticGameViewEvent) {
//        switch event {
//        case .edgeTapped:
//            getManager(StaticGameViewController.self, StaticGameViewEventManager.self).handle(event: event)
//        }
    }
    
    class func route(event: GameViewEvent) {
//        switch event {
//        case .switchMode:
//            getManager(GameViewController.self, GameViewEventManager.self).handle(event: event)
//        }
    }
}

