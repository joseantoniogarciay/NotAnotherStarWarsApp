//
//  HomeInjection.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 11/5/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class HomeInjection {
    
    class func setup() {
        
        let container = Container.shared
        
        container.register(HomePresenterProtocol.self) { (r, homeViewController: HomeViewController, peopleInteractor: PeopleInteractorProtocol?) in
            HomePresenter(homeViewController, peopleInteractor: peopleInteractor)
        }
        
        container.storyboardInitCompleted(HomeViewController.self) { r, c in
            let peopleInteractor = r.resolve(PeopleInteractorProtocol.self)
            let homePresenter = r.resolve(HomePresenterProtocol.self, arguments: c, peopleInteractor)
            c.presenter = homePresenter
        }

    }
    
}
