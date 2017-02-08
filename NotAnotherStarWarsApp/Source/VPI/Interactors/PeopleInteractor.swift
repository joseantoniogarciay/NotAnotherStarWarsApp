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
    
    func getOtherInfoMock() -> Promise<String> {
        return Promise { fulfill, reject in
            do {
                sleep(6)
                let _ = try DependencyProvider.people.getPeople()
                fulfill("moreInfo")
            } catch let error as PeopleError {
                reject(error)
            }
        }
    }
    
    func je() -> String {
        do {
            return try ..getOtherInfoMock()
        } catch {
            return ""
        }
    }

}
