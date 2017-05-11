//
//  PeopleDetailViewController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 2/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Reusable

protocol PeopleDetailViewControllerProtocol : class {
    
}

class PeopleDetailViewController: BaseViewController, StoryboardSceneBased {
    
    static var sceneStoryboard = UIStoryboard(name: AppStoryboard.People.rawValue, bundle: nil)
    var presenter: PeopleDetailPresenterProtocol?
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }
    
    override func configView() {
        title = .PeopleDetail_Title
    }

}
