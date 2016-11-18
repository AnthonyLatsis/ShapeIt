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
    fileprivate static var dict: [SIViewController] = []
}

// MARK: Event Routers
extension SIEventCenter {
    class func route(event: DynamicGameViewEvent) {
        switch event {
        case .gameOver:
            getManager(DynamicGameViewController.self, DynamicGameViewEventManager.self).handle(event: event)
        }
    }
    
    class func route(event: StaticGameViewEvent) {
        switch event {
        case .edgeTapped:
            getManager(StaticGameViewController.self, StaticGameViewEventManager.self).handle(event: event)
        }
    }
    
    class func route(event: GameViewEvent) {
        switch event {
        case .switchMode:
            getManager(GameViewController.self, GameViewEventManager.self).handle(event: event)
        }
    }
}

extension SIEventCenter {
    class func post(event: Any) {
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
    
    class func add(vc: SIViewController) {
        dict.append(vc)
    }
    
    class func remove(vc: SIViewController) {
        dict.remove(at: findIndexFor(vc: vc))
    }
}

extension SIEventCenter {
    class func findIndexFor(vc: SIViewController) -> Int {
        for (i, viewController) in dict.enumerated() {
            if viewController == vc {
                return i
            }
        }
        fatalError()
    }
    
    class func activeVCs() -> [SIViewController] {
        var vcs: [SIViewController] = []
        for vc in dict {
            if vc.active || (vc.isViewLoaded && vc.view.window != nil) || vc.view.superview != nil {
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
