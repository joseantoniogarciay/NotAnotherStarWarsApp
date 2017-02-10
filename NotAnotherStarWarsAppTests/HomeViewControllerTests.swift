//
//  HomeViewControllerTests.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 8/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import XCTest
@testable import NotAnotherStarWarsApp

class HomePresenterMock: HomePresenterProtocol {
    
    weak var homeVC : HomeViewProtocol?
    
    required init(homeVC : HomeViewProtocol) {
        self.homeVC = homeVC
    }
    
    func viewLoaded() {
        let people = Person.Builder()
            .setName("Django")
            .setHeight("2.10")
            .setMass("100")
            .build()
        self.homeVC?.updatePeople([people])
    }
    
    func selectedPerson(_ person: Person) {
        
    }

}


class HomeViewControllerTests: XCTestCase {
    
    var homeVC: HomeViewController!
    
    override func setUp() {
        super.setUp()
        homeVC = HomeViewController.instantiate()
        let _ = homeVC.view
        homeVC.presenter = HomePresenterMock(homeVC: homeVC)
    }
    
    override func tearDown() {
        homeVC = nil
        super.tearDown()
    }
    
    func testViewLoadedWithInfo() {
        homeVC.presenter?.viewLoaded()
        XCTAssert(homeVC.tableView.numberOfRows(inSection: 0) == 1)
    }
    
    func testUpdatePeople() {
        let people = Person.Builder()
            .setName("Django")
            .setHeight("2.10")
            .setMass("100")
            .build()
        homeVC.updatePeople([people])
        
    }
    
}
