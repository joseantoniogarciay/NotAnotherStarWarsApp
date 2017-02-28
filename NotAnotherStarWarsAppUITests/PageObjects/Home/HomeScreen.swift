//
//  HomeScreen.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 20/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import XCTest

class HomeScreen: NSObject {
    
    static let app = XCUIApplication()
    
    static func tapAnyPersonCell() {
        let firstChild = app.tables.children(matching:.any).element(boundBy: 0)
        if firstChild.exists {
            firstChild.tap()
        }
    }

}