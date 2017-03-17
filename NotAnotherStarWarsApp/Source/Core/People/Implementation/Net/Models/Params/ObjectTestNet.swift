//
//  ObjectTestNet.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 17/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import ObjectMapper

struct ObjectTestNet : Mappable {

    let name: String?
    let height: String?
    
    init?(map: Map) {
        name = try? map.value("name")
        height = try? map.value("height")
    }
    
    init(name: String, height: String) {
        self.name = name
        self.height = height
    }
    
    func mapping(map: Map) {
        name >>> map["name"]
        height >>> map["height"]
    }
    
}
