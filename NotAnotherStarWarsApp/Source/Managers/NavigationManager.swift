//
//  Navigationmanager.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 10/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

class NavigationManager: NSObject {
    
    var currentNavController : UINavigationController?

    static let shared = NavigationManager()
    
    fileprivate override init() {
        let homeVC = HomeViewController.instantiate()
        currentNavController = UINavigationController(rootViewController: homeVC)
    }
        
    func setNavigationController(_ navigationController: UINavigationController?){
        currentNavController = navigationController
    }
    
    func pushVC(_ viewController : UIViewController, animated: Bool){
        self.currentNavController?.pushViewController(viewController, animated: animated)
    }
    
    func popVC(animated: Bool){
        _ = self.currentNavController?.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool){
        _ = self.currentNavController?.popToRootViewController(animated: animated)
    }
    
}
