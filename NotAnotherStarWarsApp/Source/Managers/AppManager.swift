//
//  AppManager.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

public protocol AppManagerProtocol {
    
    static var shared: AppManagerProtocol { get }
    var application: UIApplication { get }
    
    func didFinishLaunching(launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: inout UIWindow?) -> Bool
    
    func willResignActive()
    
    func didEnterBackground()
    
    func willEnterForeground()
    
    func didBecomeActive()
    
    func willTerminate()
}


class AppManager: AppManagerProtocol {

    static let shared: AppManagerProtocol = AppManager()
    var application : UIApplication { get { return UIApplication.shared } }
    
    open func didFinishLaunching(launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: inout UIWindow?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationManager.shared.currentNavController
        window?.makeKeyAndVisible()
        return true
    }
    
    open func willResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    open func didEnterBackground() {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    open func willEnterForeground() {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    open func didBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    open func willTerminate() {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
