//
//  PeopleEngine.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class PeopleEngine : PeopleProtocol {
    
    private let peopleDataRecover: PeopleDataRecover
    
    init(peopleDataRecover: PeopleDataRecover) {
        self.peopleDataRecover = peopleDataRecover
    }
    
    func getPeople(completion: @escaping (([Person]?, Error?) -> Void)) -> Int {
        return peopleDataRecover.getPeople(completion: {(arrayPerson, error) in
            if arrayPerson != nil {
                completion(arrayPerson, nil)
            } else {
                completion(nil, error)
            }
        })
    }
    
    func uploadPhotos(_ photos: [Photo], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Person?, Error?) -> Void)) -> Int {
        return peopleDataRecover.uploadPhotos(photos, actualProgress: { progress in
            actualProgress(progress)
        }) { (response, error) in
            
        }
    }
    
}
