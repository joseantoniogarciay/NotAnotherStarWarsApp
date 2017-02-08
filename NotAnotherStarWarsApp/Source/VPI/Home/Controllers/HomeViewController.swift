//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Reusable

class HomeViewController: BaseViewController, StoryboardSceneBased {
    
    static var storyboard = UIStoryboard(name: "Home", bundle: nil)
    var presenter : HomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.pushViewController(PeopleDetailController.instantiate(), animated: true)
        presenter?.viewLoaded()
    }
    
    override func dependencyInjection() {
        presenter = HomePresenter(homeVC: self)
    }

}


// MARK: HomePresenter Communication
extension HomeViewController {
    
    func updatePeople(arrayPeople: [People]) {
        
    }
    
}

