//
//  HomeRouting.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/6/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

protocol HomeRoutingProtocol {
    func detailSelectedForPerson(_ person: Person, title: String)
}

class HomeRouting: HomeRoutingProtocol {
    
    func detailSelectedForPerson(_ person: Person, title: String) {
        if let peopleDetailVC = Container.shared.resolve(PeopleDetailViewController.self, argument: person) {
            NavigationManager.shared.pushVC(peopleDetailVC, animated: true)
        }
    }
    
}
