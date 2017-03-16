//
//  HomePresenter.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

protocol HomePresenterProtocol {
    weak var homeVC : HomeViewProtocol? { get set }
    init(homeVC : HomeViewProtocol)
    func viewLoaded()
    func selectedPerson(_ person: Person)
}

// MARK: HomePresenterProtocol

class HomePresenter : HomePresenterProtocol {
    
    weak var homeVC : HomeViewProtocol?
    var peopleInteractor = PeopleInteractor()
    var pushingVC = false
    
    required init(homeVC : HomeViewProtocol) {
        self.homeVC = homeVC
    }
    
    func viewLoaded() {
        getPeople()
        uploadPhoto()
        uploadPhoto()
        uploadPhoto()
    }
    
    func getPeople() {
        _ = peopleInteractor.getPeople(completion: { [weak self] (arrayPerson, error) in
            if error == nil, let persons = arrayPerson {
                self?.homeVC?.updatePeople(persons)
            } else {
                self?.homeVC?.stopTableViewActivityIndicator()
            }
        })
        .onSuccess({ [weak self] (identifier) in
            
        })
        .onError({ [weak self] (error) in
            
        })
        .execute()
    }
    
    func uploadPhoto() {
        _ = peopleInteractor.uploadPhoto(actualProgress: { (progress) in
            
        }, completion: { (response, error) in
            
        })
        .onSuccess({ (identifier) in
            print(identifier)
            //self.peopleInteractor.cancelTask(identifier: identifier)
        })
        .onError({ (error) in
            print(error)
        })
        .execute()
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
        _ = peopleInteractor.getDetailTitle()
        .onSuccess({ [weak self] (title) in
            peopleDetailVC.title = title
            self?.homeVC?.showLoadingForPerson(person, show: false)
            NavigationManager.shared.pushVC(peopleDetailVC, animated: true)
            self?.pushingVC = false
        })
        .execute()
    }
    
}
