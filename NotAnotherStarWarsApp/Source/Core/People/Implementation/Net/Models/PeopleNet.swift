//
//  PeopleNet.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import ObjectMapper

class PeopleNet : Mappable {
    
    let name: String?
    let height: String?
    let mass: String?
    
    required init?(map: Map) {
        name = try? map.value("name")
        height = try? map.value("height")
        mass = try? map.value("mass")
    }
    
    func mapping(map: Map) {
        name >>> map["name"]
        height >>> map["height"]
        mass >>> map["mass"]
    }
}
