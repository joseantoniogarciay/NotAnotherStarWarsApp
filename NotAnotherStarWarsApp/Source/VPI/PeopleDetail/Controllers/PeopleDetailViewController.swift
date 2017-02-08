//
//  PeopleDetailViewController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 2/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Reusable

class PeopleDetailViewController: BaseViewController, StoryboardSceneBased {
    
    static var storyboard = UIStoryboard(name: "People", bundle: nil)
    var presenter: PeopleDetailPresenterProtocol?
    
    var person: People?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }
    
    override func dependencyInjection() {
        presenter = PeopleDetailPresenter(peopleDetailVC: self)
    }
    
    override func configView() {
        navigationController?.navigationBar.backItem?.title = ""
    }

}
