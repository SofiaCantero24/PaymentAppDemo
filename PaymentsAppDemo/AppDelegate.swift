//
//  AppDelegate.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/22/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let amountViewController: AmountViewController = AmountViewController.loadFromNib()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = amountViewController
        window?.makeKeyAndVisible()
        return true
    }
}

