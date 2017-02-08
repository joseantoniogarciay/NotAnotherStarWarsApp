//
//  HomePresenter.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Hydra

protocol HomePresenterProtocol {
    weak var homeVC : HomeViewController? { get set }
    init(homeVC : HomeViewController)
    func viewLoaded()
    func wayToPersonDetail(_ peopleDetailVC: PeopleDetailViewController)
}

class HomePresenter : HomePresenterProtocol {
    
    weak var homeVC : HomeViewController?
    var peopleInteractor = PeopleInteractor()
    
    required init(homeVC : HomeViewController) {
        self.homeVC = homeVC
    }
    
    func viewLoaded() {
        getPeople()
    }
    
    func wayToPersonDetail(_ peopleDetailVC: PeopleDetailViewController) {
        print(self.peopleInteractor.je())
    }
    
    func getPeople() {
        self.peopleInteractor.getPeople()
        .then(in: .main) { [weak self] arrayPeople in
            self?.homeVC?.updatePeople(arrayPeople: arrayPeople)
        }
        .catch(in: .main, { (error) in
                
        })
    }

}
