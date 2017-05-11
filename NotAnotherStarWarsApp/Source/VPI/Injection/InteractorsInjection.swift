//
//  InteractorsInjection.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 11/5/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class InteractorsInjection {
    
    class func setup() {
        
        let container = Container.shared
        
        container.register(PeopleInteractorProtocol.self) { r in
            return PeopleInteractor()
        }

    }
}
