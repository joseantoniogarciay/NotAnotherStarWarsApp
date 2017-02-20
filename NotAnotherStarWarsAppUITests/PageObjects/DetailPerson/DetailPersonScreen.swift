//
//  DetailPersonScreen.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 20/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import XCTest

class DetailPersonScreen: NSObject {
    
    static let app = XCUIApplication()
    
    static func getTitle() -> String {
        return app.navigationBars.element.identifier
    }
    
}
