//
//  HomeInteractor.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import PromiseKit

class HomeInteractor {
    
    func getPeople() -> Promise<[People]> {
        return Promise { fulfill, reject in
            do {
                let arrayPeople = try DependencyProvider.people.getPeople()
                fulfill(arrayPeople)
            } catch let error as PeopleError {
                reject(error)
            }
        }
    }

}
