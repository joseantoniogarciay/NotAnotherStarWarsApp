//
//  ObjectTestNetTransformer.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 17/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class ObjectTestNetTransformer {
    
    static func transform(from objectTest: ObjectTest) -> ObjectTestNet {
        return ObjectTestNet(name: objectTest.name, height: objectTest.height)
    }

}
