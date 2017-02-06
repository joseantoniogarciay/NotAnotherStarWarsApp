//
//  PeopleParser.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

import Foundation

class PeopleParser {
    
    // MARK: parsePagePeople
    static func parsePagePeople(_ dependencies: PagePeopleNet) throws -> [People] {
        
        guard let arrayPeopleNet = dependencies.arrayPeople else {
            throw PeopleError.nullResponse
        }
        
        let arrayPeople = arrayPeopleNet.map({ peopleNet -> People in
            PeopleTransformer.transform(with: peopleNet)
        })
        return arrayPeople
    }
    
}
