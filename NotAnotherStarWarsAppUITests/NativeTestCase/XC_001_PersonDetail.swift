//
//  XC_001_PersonDetail.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 10/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import XCTest
import XCTest_Gherkin

class XC_001_Register: NativeTestCase {
    
    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        app.launch()
    }
    
    override class open func path() -> URL? {
        let targetName = Bundle.main.infoDictionary?["CFBundleName"] as! String
        let url = Bundle.main.resourceURL?.appendingPathComponent("PlugIns/" + targetName + ".xctest/Features/001_PersonDetail")
        return url
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
