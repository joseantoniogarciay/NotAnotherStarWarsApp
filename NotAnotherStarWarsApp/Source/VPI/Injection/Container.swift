//
//  Container.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 11/5/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class Container {
    static let shared = SwinjectStoryboard.defaultContainer
}

extension SwinjectStoryboard {
    
    class func setup() {
        InteractorsInjection.setup()
        HomeInjection.setup()
        PeopleDetailInjection.setup()
    }

}
