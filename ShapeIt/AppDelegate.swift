//
//  AppDelegate.swift
//  ShapeIt
//
//  Created by Anthony Latsis on 21.11.16.
//  Copyright © 2016 Anthony Latsis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        loadRootViewController()
        return true
    }
}

extension AppDelegate {
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.clear
    }
    
    func loadRootViewController() {
        window!.rootViewController = GameViewController()
        window!.makeKeyAndVisible()
    }
}

