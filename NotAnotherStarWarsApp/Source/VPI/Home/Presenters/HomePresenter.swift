//
//  HomePresenter.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

class HomePresenter {
    
    weak var homeVC : HomeViewController?
    var homeInteractor = HomeInteractor()
    
    required init(homeVC : HomeViewController) {
        self.homeVC = homeVC
    }
    
    func viewLoaded() {
        getPeople()
    }
    
    private func getPeople() {
        DispatchQueue.global().async {
            self.homeInteractor.getPeople()
            .then(on: DispatchQueue.main) { [weak self] arrayPeople in
                self?.homeVC?.updatePeople(arrayPeople: arrayPeople)
            }
            .catch(execute:{ (error) in
                    
            })
        }
    }

}
