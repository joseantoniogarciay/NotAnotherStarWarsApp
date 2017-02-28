//
//  PersonTransformer.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 6/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class PersonTransformer: TransformableProtocol {
    
    static func transform(with personNet: PersonNet) -> Person? {
        guard let name = personNet.name else { return nil }

        return Person.Builder()
            .setName(name)
            .setHeight(personNet.height)
            .setMass(personNet.mass)
            .build()
    }

}
