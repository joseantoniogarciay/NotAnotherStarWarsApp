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
    static func parsePagePeople(_ dependencies: PagePeopleNet) throws -> [Person] {
        
        guard let arrayPeopleNet = dependencies.arrayPeople else {
            throw PeopleError.nullResponse
        }
        
        let arrayPeople = arrayPeopleNet.map({ peopleNet -> Person in
            PersonTransformer.transform(with: peopleNet)
        })
        return arrayPeople
    }
    
}
