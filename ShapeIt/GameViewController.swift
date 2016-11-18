//
//  GameViewController.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 30.10.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

// The main aim is to generate a figure using a matrix, then filter it, randomize and display.
// The Game map on the screen is like a matrix, and if element (i, j) is Bool(true), it should display a square using EDGEVIEWS. This is the easiest way to generate a template for the following figure. Once there is a template, we can remove some INNER edges to make it more hollow. Finally, we have to randomly rotate every edge in such a way that the user amuses himself trying to complete the figure

// EXAMPLE

//        _________________
//       |        |        |
//       |        |        |
//       |        |        |                     THIS IS A RANDOM FIGURE
//       |________|________|________
//                         |        |
//                         |        |
//                         |        |
//                         |________|


//        _________________
//       |                 |
//       |                 |
//       |                 |                     THIS COULD BE IT AFTER FILTERING SOME EDGES
//       |_________________|________
//                         |        |
//                         |        |
//                         |        |
//                         |________|



//            |
//            |    ________
//        |   |
//        |   |        ________                  RANDOM ROTATING.
//        |   |
//        |   |    ________ ________
//            |            |
//            |            |    ________
//                         |   |
//                         |   |
//                             |
//                             |
import UIKit

enum GameMode {
    case regular
    case dynamic
}

protocol GameViewEventManager: class {
    func handle(event: GameViewEvent)
    func catchEvent(in object: UIView)
}

extension GameViewEventManager {
    func handle(event: GameViewEvent) {}
    func catchEvent(in sender: UIView) {}
}

class GameViewController: SIViewController {
    let mainView = GameView()
    
    var staticGameVC: StaticGameViewController? = nil
    var dynamicGameVC: DynamicGameViewController? = nil
    
    var mode: GameMode {
        didSet {
            switchMode()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchMode()
    }
    
    init(mode: GameMode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameViewController {
    func switchMode() {
        switch mode {
        case .regular:
            mainView.clearContainer()
            if let dynamicVC = dynamicGameVC {
                dynamicVC.removeFromParentViewController()
                dynamicVC.didMove(toParentViewController: nil)
                self.dynamicGameVC?.mainView.clear(restart: false)
                self.dynamicGameVC = nil
            }
            let staticGameVC = StaticGameViewController()
            self.addChildViewController(staticGameVC)
            mainView.insertGame(view: staticGameVC.mainView)
            staticGameVC.didMove(toParentViewController: self)
            
            self.staticGameVC = staticGameVC
            
        case .dynamic:
            mainView.clearContainer()
            if let staticVC = staticGameVC {
                staticVC.removeFromParentViewController()
                staticVC.didMove(toParentViewController: nil)
                self.staticGameVC = nil
            }
            let dynamicGameVC = DynamicGameViewController()
            self.addChildViewController(dynamicGameVC)
            mainView.insertGame(view: dynamicGameVC.mainView)
            dynamicGameVC.didMove(toParentViewController: self)
            
            self.dynamicGameVC = dynamicGameVC
        }
    }
}

extension GameViewController: GameViewEventManager {
    func handle(event: GameViewEvent) {
        switch event {
        case .switchMode:
            if mode == .dynamic {
                mode = .regular
            } else {
                mode = .dynamic
            }
        }
    }
}
