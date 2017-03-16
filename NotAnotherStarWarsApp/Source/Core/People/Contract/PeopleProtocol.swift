//
//  PeopleProtocol.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

protocol PeopleProtocol {
    func getPeople(completion: @escaping ((Bool, [Person]?, Error?) -> Void)) -> Int
    func uploadArchives(uploadUrl: String, otherParameters:[String: String], auth : Bool, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Bool, Person?, Error?) -> Void)) -> Int
}
