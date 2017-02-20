//
//  BaseViewController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

protocol DependencyInjectionProtocol {
    func dependencyInjection()
}

class BaseViewController: UIViewController, DependencyInjectionProtocol {
    
    override var navigationController: UINavigationController? {
        get { return nil } //Hard restriction
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dependencyInjection()
        configView()
    }
    
    func dependencyInjection() {
        preconditionFailure("This method must be overridden")
    }
    
    func configView() {
        
    }
    
}
