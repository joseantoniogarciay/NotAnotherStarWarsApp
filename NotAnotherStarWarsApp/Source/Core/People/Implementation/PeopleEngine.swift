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
    
    func getPeople(completion: @escaping ((Bool, [Person]?, Error?) -> Void)) -> Int {
        return peopleDataRecover.getPeople(completion: {(result, arrayPerson, error) in
            if arrayPerson != nil {
                completion(true, arrayPerson, nil)
            } else {
                completion(false, nil, error)
            }
        })
    }
    
    func uploadArchives(uploadUrl: String, otherParameters:[String: String], auth : Bool, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Bool, Person?, Error?) -> Void)) -> Int {
        return peopleDataRecover.uploadArchives(uploadUrl: uploadUrl, otherParameters: otherParameters, auth: auth, archives: archives, actualProgress: { progress in
            actualProgress(progress)
        }) { (result, response, error) in
            
        }
    }
    
}
