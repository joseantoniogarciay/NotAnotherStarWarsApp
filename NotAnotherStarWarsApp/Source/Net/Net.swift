//
//  Net.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

protocol Net {
    func launchRequest(_ request: Request, completion: @escaping ((NetworkResponse?, NetError?) -> Void)) -> Int
    func uploadRequest(_ request: Request, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((NetworkResponse?, NetError?) -> Void)) -> Int
    func isReachable() -> Bool
    func cancelTask(identifier: Int)
}
