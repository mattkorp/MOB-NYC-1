//
//  AppDelegate.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        var bounds = UIScreen.mainScreen().bounds
        self.window = UIWindow(frame: bounds)
        var frame = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds))
        var arrayViewController = ArrayViewController(frame: frame)
        self.window?.rootViewController = UINavigationController(rootViewController: arrayViewController)
        self.window!.makeKeyAndVisible()
        
        return true
    }

}

