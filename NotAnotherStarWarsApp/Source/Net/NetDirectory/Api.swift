//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

struct Api {
    
    let PEOPLE: String

    init (baseUrlDirectory: String) {
        self.PEOPLE = "\(baseUrlDirectory)\(NetApi.PEOPLE)"
    }
}