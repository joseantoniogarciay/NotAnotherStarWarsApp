//
//  Person.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

class Person: NSObject {
    let name: String
    let height: String?
    let mass: String?
    
    private init(builder: Builder) {
        name = builder.name
        height = builder.height
        mass = builder.mass
    }
    
    public class Builder {
        var name: String = ""
        var height: String?
        var mass: String?

        func setName(_ name: String) -> Builder {
            self.name = name
            return self
        }
        
        func setHeight(_ height: String?) -> Builder {
            self.height = height
            return self
        }
        
        func setMass(_ mass: String?) -> Builder {
            self.mass = mass
            return self
        }
        
        func build() -> Person {
            return Person(builder: self)
        }
        
    }
    
}
