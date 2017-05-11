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
    init(_ homeViewController: HomeViewControllerProtocol?, peopleInteractor: PeopleInteractorProtocol?)
    func viewLoaded()
    func selectedPerson(_ person: Person)
}

// MARK: HomePresenterProtocol

class HomePresenter : HomePresenterProtocol {
    
    weak var homeVC : HomeViewControllerProtocol?
    var peopleInteractor : PeopleInteractorProtocol?
    var pushingVC = false
    
    required init(_ homeViewController: HomeViewControllerProtocol?, peopleInteractor: PeopleInteractorProtocol?) {
        self.homeVC = homeViewController
        self.peopleInteractor = peopleInteractor
    }
    
    func viewLoaded() {
        getPeople()
        testUploadPhotoFake()
    }
    
    func getPeople() {
        _ = peopleInteractor?.getPeople(completion: { [weak self] (arrayPerson, error) in
            if error == nil, let persons = arrayPerson {
                self?.homeVC?.updatePeople(persons)
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
    
    func selectedPerson(_ person: Person) {
        guard pushingVC == false else { return }
        pushingVC = true
        homeVC?.showLoadingForPerson(person, show: true)
        if let peopleDetailVC = Container.shared.resolve(PeopleDetailViewController.self, argument: person) {
            _ = peopleInteractor?.getDetailTitle()
            .onSuccess({ [weak self] (title) in
                peopleDetailVC.title = title
                self?.homeVC?.showLoadingForPerson(person, show: false)
                NavigationManager.shared.pushVC(peopleDetailVC, animated: true)
                self?.pushingVC = false
            })
            .execute()
        }
    }
    
}
