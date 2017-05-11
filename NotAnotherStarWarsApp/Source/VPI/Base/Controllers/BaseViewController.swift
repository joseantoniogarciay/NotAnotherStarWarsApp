//
//  BaseViewController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override var navigationController: UINavigationController? {
        get { return nil } //Hard restriction
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        
    }
    
}
