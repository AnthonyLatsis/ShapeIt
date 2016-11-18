//
//  DynamicGameViewController.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 16.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

protocol DynamicGameViewEventManager {
    func handle(event: DynamicGameViewEvent)
}

class DynamicGameViewController: SIViewController {
    let mainView = DynamicGameView()
    
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

extension DynamicGameViewController: DynamicGameViewEventManager {
    func handle(event: DynamicGameViewEvent) {
        mainView.clear(restart: false)
        
        let alert = UIAlertController(title: "game over", message: "you suck", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel) {
            _ in
            self.mainView.setUI()
        }
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
