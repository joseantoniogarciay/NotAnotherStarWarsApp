//
//  AppDelegateTests.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import XCTest
@testable import NotAnotherStarWarsApp

class AppManagerMock: AppManagerProtocol {
    
    private(set) var didFinishLaunchingCalled = false
    private(set) var willResignActiveCalled = false
    private(set) var didEnterBackgroundCalled = false
    private(set) var willEnterForegroundCalled = false
    private(set) var didBecomeActiveCalled = false
    private(set) var willTerminateCalled = false
    
    open static let shared: AppManagerProtocol = AppManagerMock()
    var application : UIApplication { get { return UIApplication.shared } }
    
    func didFinishLaunching(launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: inout UIWindow?) -> Bool {
        didFinishLaunchingCalled = true
        return false
    }
    
    func willResignActive() {
        willResignActiveCalled = true
    }
    
    func didEnterBackground() {
        didEnterBackgroundCalled = true
    }
    
    func willEnterForeground() {
        willEnterForegroundCalled = true
    }
    
    func didBecomeActive() {
        didBecomeActiveCalled = true
    }
    
    func willTerminate() {
        willTerminateCalled = true
    }
    
}

class AppDelegateTests: XCTestCase {
    
    var application: UIApplication!
    var appDelegate: AppDelegate!
    var appManager: AppManagerMock!
    
    override func setUp() {
        super.setUp()
        appManager = AppManagerMock.shared as! AppManagerMock
        application = appManager.application 
        appDelegate = application.delegate as! AppDelegate
        appDelegate.appManager = appManager
    }
    
    override func tearDown() {
        application = nil
        appDelegate = nil
        appManager = nil
        super.tearDown()
    }
    
    func testDidFinishLaunching() {
        XCTAssertFalse(appDelegate.application(application, didFinishLaunchingWithOptions: nil))
        XCTAssertTrue(appManager.didFinishLaunchingCalled)
    }
    
    func testWillResignActive() {
        appDelegate.applicationWillResignActive(application)
        XCTAssertTrue(appManager.willResignActiveCalled)
    }
    
    func testDidEnterBackground() {
        appDelegate.applicationDidEnterBackground(application)
        XCTAssertTrue(appManager.didEnterBackgroundCalled)
    }
    
    func testWillEnterForeground() {
        appDelegate.applicationWillEnterForeground(application)
        XCTAssertTrue(appManager.willEnterForegroundCalled)
    }
    
    func testDidBecomeActive() {
        appDelegate.applicationDidBecomeActive(application)
        XCTAssertTrue(appManager.didBecomeActiveCalled)
    }
    
    func testWillTerminate() {
        appDelegate.applicationWillTerminate(application)
        XCTAssertTrue(appManager.willTerminateCalled)
    }
    
}
