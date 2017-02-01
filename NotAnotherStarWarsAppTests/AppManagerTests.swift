//
//  AppManagerTests.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import XCTest
@testable import NotAnotherStarWarsApp

class AppManagerTests: XCTestCase {
    
    var appManager: AppManagerProtocol!
    
    override func setUp() {
        super.setUp()
        appManager = AppManager.shared
    }
    
    override func tearDown() {
        appManager = nil
        super.tearDown()
    }
    
    func testDidFinishLaunching() {
        XCTAssertTrue(appManager.didFinishLaunching(launchOptions: nil))
    }
    
    func testWillResignActive() {
        appManager.willResignActive()
    }
    
    func testDidEnterBackground() {
        appManager.didEnterBackground()
    }
    
    func testWillEnterForeground() {
        appManager.willEnterForeground()
    }
    
    func testDidBecomeActive() {
        appManager.didBecomeActive()
    }
    
    func testWillTerminate() {
        appManager.willTerminate()
    }
    
}
