//
//  StaticGameViewController.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 16.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

protocol StaticGameViewEventManager {
    func handle(event: StaticGameViewEvent)
}

class StaticGameViewController: SIViewController {
    let mainView = StaticGameView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StaticGameViewController: StaticGameViewEventManager {
    func handle(event: StaticGameViewEvent) {
        switch event {
        case .edgeTapped:
            if mainView.isFigureComplete() {
                mainView.animateFigureCompletion()
            }
        }
    }
}
