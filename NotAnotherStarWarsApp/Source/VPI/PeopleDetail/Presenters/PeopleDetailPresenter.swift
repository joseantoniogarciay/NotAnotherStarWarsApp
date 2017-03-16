//
//  PeopleDetailPresenter.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 2/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

protocol PeopleDetailPresenterProtocol {
    weak var peopleDetailVC: PeopleDetailViewController? { get set }
    init(peopleDetailVC: PeopleDetailViewController)
    func viewLoaded()
}

class PeopleDetailPresenter: PeopleDetailPresenterProtocol {
    
    weak var peopleDetailVC : PeopleDetailViewController?
    var peopleInteractor = PeopleInteractor()
    
    required init(peopleDetailVC: PeopleDetailViewController) {
        self.peopleDetailVC = peopleDetailVC
    }
    
    func viewLoaded() {
        
    }

}
