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
        
        container.register(HomeRoutingProtocol.self) { _ in
            HomeRouting()
        }
        
        container.register(HomePresenterProtocol.self) { (r, homeViewController: HomeViewController, peopleInteractor: PeopleInteractorProtocol?, homeRouting: HomeRoutingProtocol?) in
            HomePresenter(homeViewController, peopleInteractor: peopleInteractor, homeRouting: homeRouting)
        }
        
        container.storyboardInitCompleted(HomeViewController.self) { r, c in
            let peopleInteractor = r.resolve(PeopleInteractorProtocol.self)
            let homeRouting = r.resolve(HomeRoutingProtocol.self)
            let homePresenter = r.resolve(HomePresenterProtocol.self, arguments: c, peopleInteractor, homeRouting)
            c.presenter = homePresenter
        }

    }
    
}
