//
//  DynamicGameView.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 07.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

struct DynamicGameConstants {
    static let startPoint = CGPoint(x: Screen.width / 2, y: -Screen.height * 0.5)
    static let mediumPoint = Screen.center
    static let endPoint = CGPoint(x: Screen.width / 2, y: Screen.height * 1.5)
    
    static let durationForSection: Double = 15.0
    
    static let sectionHeight: CGFloat = Screen.height / 2
}

class DynamicGameView: SIView {
    var figureViewQueue = Queue<AnimatedFigureView>()
    
    init() {
        super.init(frame: Screen.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DynamicGameView {
    override func setTargets() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapEdge(sender:)))
        
        self.addGestureRecognizer(gesture)
    }
    
    override func setUI() {
        backgroundColor = Style.lightPurple

        addNewFigureView(position: CGPoint(x: Screen.width / 2, y: 0.0))
    }
}

extension DynamicGameView {
    func didTapEdge(sender: UITapGestureRecognizer) {
        let tapX = sender.location(in: self).x
        let tapY = sender.location(in: self).y
        
        guard let figureView = figureViewForTouch(at: CGPoint(x: tapX, y: tapY)) else {
            return
        }
        let currentCenterY = figureView.center.y + positionDeltaFor(figureView: figureView)
        
        let actualTapY = Screen.height - abs((currentCenterY + DynamicGameConstants.sectionHeight) - tapY)
    
        let optionalEdge = figureView.findClosestEdge(to: CGPoint(x: tapX, y: actualTapY))
        
        guard let edge = optionalEdge else {
            return
        }
        let rotation = Animations.rotation(angle: M_PI_2, duration: 0.2, repeats: 1.0, timingFunction: CAMediaTimingFunction.Linear)
        
        edge.layer.add(rotation, forKey: nil)

        edge.changeOrientation(rotate: false)
    }
}

// MARK: Managing FigureView Queue
extension DynamicGameView {
    func addNewFigureView(position: CGPoint) {
        let interval = duration(for: position)
        
        let animation = Animations.positionAnimation(duration: interval, points: [position, Screen.center], timingFunction: CAMediaTimingFunction.Linear, delegate: self)
        
        let newFigureView = AnimatedFigureView(mode: .dynamic, delegate: self, anim: animation)
        
        self.insert(subviews: [newFigureView], at: 10)
        
        newFigureView.center = position
        
        figureViewQueue.enqueue(element: newFigureView)
    }
    
    func removeFigure() {
        figureViewQueue.dequeueAndPop().removeFromSuperview()
    }
    
    func clear(restart: Bool) {
        while figureViewQueue.count > 0 {
            figureViewQueue.dequeueAndPop().removeFromSuperview()
        }
        if restart {
            setUI()
        }
    }
}

// MARK: Pure logic
extension DynamicGameView {
    func figureViewForTouch(at point: CGPoint) -> AnimatedFigureView? {
        let figureView = figureViewQueue.getFirst()
        
        let startPosition = figureView.center
        
        let currentCenterY = startPosition.y + positionDeltaFor(figureView: figureView)
        
        if point.y >= currentCenterY - DynamicGameConstants.sectionHeight && point.y <= currentCenterY + DynamicGameConstants.sectionHeight {
            return figureView
        } else {
            if figureViewQueue.count == 1 {
                return nil
            } else {
                return figureViewQueue.getLast()
            }
        }
    }
    
    /** The delta of the start and current positions of a figureView. Note that this is the delta caused by the position animation */
    func positionDeltaFor(figureView: AnimatedFigureView) -> CGFloat {
        let sectionsToPass = CGFloat(numberOfSectionsToPass(start: figureView.center))
        
        let passedPart = CGFloat(abs(figureView.startDate.timeIntervalSinceNow) / duration(for: figureView.center))
        
        return DynamicGameConstants.sectionHeight * sectionsToPass * passedPart
    }
    
    func numberOfSectionsToPass(start: CGPoint) -> Int {
        return Int(abs((DynamicGameConstants.mediumPoint.y - start.y)) / DynamicGameConstants.sectionHeight)
    }
    
    func duration(for position: CGPoint) -> Double {
        return DynamicGameConstants.durationForSection * Double(numberOfSectionsToPass(start: position))
    }
}

extension DynamicGameView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag else {
            return
        }
        let animation = Animations.positionAnimation(duration: duration(for: DynamicGameConstants.endPoint), points: [DynamicGameConstants.mediumPoint, DynamicGameConstants.endPoint], timingFunction: CAMediaTimingFunction.Linear)
        
        figureViewQueue.getLast().layer.add(animation, forKey: nil)
        
        if figureViewQueue.count == 1 {
            addNewFigureView(position: DynamicGameConstants.startPoint)
        } else {
            addNewFigureView(position: DynamicGameConstants.startPoint)
            removeFigure()
        }
    }
}

extension DynamicGameView: AnimatedFigureViewDelegate {
    func didMove(figureView: AnimatedFigureView) {
        for (i, edge) in figureView.edges.enumerated() {
            let currentCenterY = figureView.center.y + positionDeltaFor(figureView: figureView)
            
            let edgeY = edge.center.y
            
            guard currentCenterY > Screen.center.y else {
                return
            }
            if edgeY > Screen.height - ((currentCenterY + Screen.height / 2) - Screen.height) {
                if edge.orientation != figureView.orientationForCompleteFigure[i] {
                    SIEventCenter.post(event: DynamicGameViewEvent.gameOver)
                }
            }
        }
    }
}
