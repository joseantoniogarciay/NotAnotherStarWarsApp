//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

protocol Net {
    func launchRequest(_ request: Request) throws -> NetworkResponse!
    func isReachable() -> Bool
}
