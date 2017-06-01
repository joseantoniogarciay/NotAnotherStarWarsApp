//
//  HomePresenter.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

protocol HomePresenterProtocol {
    weak var homeVC : HomeViewControllerProtocol? { get set }
    init(_ homeViewController: HomeViewControllerProtocol?, peopleInteractor: PeopleInteractorProtocol?, homeRouting: HomeRoutingProtocol?)
    func viewLoaded()
    func selectedPerson(_ person: PersonViewModel)
}

// MARK: HomePresenterProtocol

class HomePresenter: HomePresenterProtocol {
    
    weak var homeVC: HomeViewControllerProtocol?
    var homeRouting: HomeRoutingProtocol?
    var peopleInteractor: PeopleInteractorProtocol?
    var pushingVC = false
    
    required init(_ homeViewController: HomeViewControllerProtocol?, peopleInteractor: PeopleInteractorProtocol?, homeRouting: HomeRoutingProtocol?) {
        self.homeVC = homeViewController
        self.peopleInteractor = peopleInteractor
        self.homeRouting = homeRouting
    }
    
    func viewLoaded() {
        getPeople()
        testUploadPhotoFake()
    }
    
    func getPeople() {
        _ = peopleInteractor?.getPeople(completion: { [weak self] (arrayPerson, error) in
            if error == nil, let persons = arrayPerson {
                self?.homeVC?.updatePeople(persons.map { return PersonViewModel(person: $0) })
            } else {
                self?.homeVC?.stopTableViewActivityIndicator()
            }
        })
        .onSuccess({ (identifier) in
            print(identifier)
        })
        .onError({ (error) in
            let description = error?.localizedDescription ?? ""
            print(description)
        })
        .execute()
    }
    
    func testUploadPhotoFake() {
        var imageData = Data()
        let image : UIImage? = #imageLiteral(resourceName: "Vader")
        if let imageVader = image, let data = UIImageJPEGRepresentation(imageVader, 1) {
            imageData = data
        }
        let photo = Photo.Builder()
            .setData(imageData)
            .setMimeType("je")
            .setName("lolz").build()
        guard let photoToSend = photo else { return }
        
        //Testing/Showing fake upload (only conceptual)
        uploadPhotos([photoToSend])
        uploadPhotos([photoToSend])
        uploadPhotos([photoToSend])
    }
    
    func uploadPhotos(_ photos: [Photo]) {
        _ = peopleInteractor?.uploadPhotos(photos, actualProgress: { (progress) in
            
        }, completion: { (response, error) in
            if let err = error {
                print(err)
            }
        })
        .onSuccess({ (identifier) in
            print(identifier)
            self.peopleInteractor?.cancelTask(identifier: identifier)
        })
        .onError({ (error) in
            let description = error?.localizedDescription ?? ""
            print(description)
        })
        .execute()
    }

}

// MARK : Navigation Methods

extension HomePresenter {
    
    func selectedPerson(_ personVM: PersonViewModel) {
        guard pushingVC == false else { return }
        pushingVC = true
        personVM.loading = true
        homeVC?.showLoadingForPerson(personVM, show: true)
        
        _ = peopleInteractor?.getDetailTitle()
            .onSuccess({ [weak self] (title) in
                self?.homeRouting?.detailSelectedForPerson(personVM.person, title: title)
                self?.resetPushingForPerson(personVM)
            })
            .onError({[weak self]  _ in
                self?.resetPushingForPerson(personVM)
            })
            .execute()
    }
    
    private func resetPushingForPerson(_ person: PersonViewModel) {
        self.pushingVC = false
        person.loading = false
        homeVC?.showLoadingForPerson(person, show: false)
    }
    
}
