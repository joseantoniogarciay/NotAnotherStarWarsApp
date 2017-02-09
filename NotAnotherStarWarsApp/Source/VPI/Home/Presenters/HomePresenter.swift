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
    func selectedPerson(_ person: Person)
}

class HomePresenter : HomePresenterProtocol {
    
    weak var homeVC : HomeViewController?
    var peopleInteractor = PeopleInteractor()
    var pushingVC = false
    
    required init(homeVC : HomeViewController) {
        self.homeVC = homeVC
    }
    
    func viewLoaded() {
        getPeople()
    }
    
    func getPeople() {
        peopleInteractor.getPeople()
            .then(in: .main) { [weak self] arrayPerson in
                self?.homeVC?.updatePeople(arrayPerson)
            }
            .catch(in: .main, { (error) in
                // TODO : self?.homeVC?.showErrorPeople()
            })
    }

}

// MARK : Navigation Methods

extension HomePresenter {
    
    func selectedPerson(_ person: Person) {
        guard pushingVC == false else { return }
        pushingVC = true
        homeVC?.showLoadingForPerson(person, show: true)
        let peopleDetailVC = PeopleDetailViewController.instantiate()
        peopleDetailVC.person = person
        self.peopleInteractor.getDetailTitle()
        .then(in: .main) { [weak self] text in
            peopleDetailVC.title = text
            self?.homeVC?.showLoadingForPerson(person, show: false)
            self?.homeVC?.navigationController?.pushViewController(peopleDetailVC, animated: true)
            self?.pushingVC = false
        }
    }
    
}
