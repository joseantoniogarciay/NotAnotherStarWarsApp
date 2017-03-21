//
//  ObjectTest.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 17/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

class ObjectTest : NSObject {

    let name: String
    let height: String
    
    private init(builder: Builder) {
        name = builder.name
        height = builder.height
    }
    
    public class Builder {
        var name: String = ""
        var height: String = ""
        
        func setName(_ name: String) -> Builder {
            self.name = name
            return self
        }
        
        func setHeight(_ height: String) -> Builder {
            self.height = height
            return self
        }
        
        func build() -> ObjectTest {
            return ObjectTest(builder: self)
        }
        
    }
    
}
