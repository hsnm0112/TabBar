//
//  AppDelegate.swift
//  TabBar
//
//  Created by hsnm on 2018/10/09.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController.instantiate()
        window?.makeKeyAndVisible()
        return true
    }
}

