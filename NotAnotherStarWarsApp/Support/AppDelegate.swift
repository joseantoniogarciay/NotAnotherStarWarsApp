//
//  AppDelegate.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appManager: AppManagerProtocol = AppManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return appManager.didFinishLaunching(launchOptions: launchOptions)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        appManager.willResignActive()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        appManager.didEnterBackground()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        appManager.willEnterForeground()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appManager.didBecomeActive()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        appManager.willTerminate()
    }

}

