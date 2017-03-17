//
//  PeopleProtocol.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

protocol PeopleProtocol {
    func getPeople(completion: @escaping (([Person]?, Error?) -> Void)) -> Int
    func uploadPhotos(_ photos: [Photo], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Person?, Error?) -> Void)) -> Int
}
