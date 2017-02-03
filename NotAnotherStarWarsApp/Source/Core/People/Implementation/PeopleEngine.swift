//
//  PeopleEngine.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class PeopleEngine : PeopleProtocol {
    
    fileprivate let peopleDataRecover: PeopleDataRecover
    
    init(peopleDataRecover: PeopleDataRecover) {
        self.peopleDataRecover = peopleDataRecover
    }
    
    func getPeople() throws -> [People] {
        do {
            return try peopleDataRecover.getPeople()
        } catch NetError.error(let code, let message){
            throw PeopleError.error(statusErrorCode: code, errorMessage: message)
        }
    }
    
    
    
}
