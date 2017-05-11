//
//  PeopleDetailInjection.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 11/5/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class PeopleDetailInjection {
    
    class func setup() {
        
        let container = Container.shared
        
        container.register(PeopleDetailViewController.self) { (r, person: Person) in
            let c = PeopleDetailViewController.instantiate()
            c.person = person
            return c
        }
        
        container.register(PeopleDetailPresenterProtocol.self) { (r, peopleDetailViewController: PeopleDetailViewControllerProtocol) in
            PeopleDetailPresenter(peopleDetailViewController)
        }
        
        container.storyboardInitCompleted(PeopleDetailViewController.self) { _ in }
        
    }
    
}
