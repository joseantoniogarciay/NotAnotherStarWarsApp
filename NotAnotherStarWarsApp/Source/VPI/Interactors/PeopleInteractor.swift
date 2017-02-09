//
//  PeopleInteractor.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Hydra

class PeopleInteractor {
    
    func getPeople() -> Promise<[Person]> {
        return Promise { fulfill, reject in
            do {
                let arrayPerson = try DependencyProvider.people.getPeople()
                fulfill(arrayPerson)
            } catch let error as PeopleError {
                reject(error)
            }
        }
    }
    
    
    
    func getDetailTitle() -> Promise<String> {
        return Promise { fulfill, reject in
            sleep(3)
            fulfill("Detail")
        }
    }

}
