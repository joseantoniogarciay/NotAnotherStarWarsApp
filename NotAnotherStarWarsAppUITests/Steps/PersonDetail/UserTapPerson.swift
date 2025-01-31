//
//  UserTapPerson.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 10/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

import XCTest
import XCTest_Gherkin

class UserTapPerson: StepDefiner {
    
    let app = XCUIApplication()
    
    override func defineSteps() {
        
        step("User taps a person") {
            sleep(3)
            HomeScreen.tapAnyPersonCell()
        }
        
    }
}

