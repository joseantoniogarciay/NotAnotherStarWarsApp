//
//  PagePeopleNet.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import ObjectMapper

struct PagePeopleNet : Mappable {
    
    let count: String?
    let next: String?
    let previous: String?
    let arrayPeople : [PersonNet]?
    
    init?(map: Map) {
        count = try? map.value("count")
        next = try? map.value("next")
        previous = try? map.value("previous")
        arrayPeople = try? map.value("results")
    }
    
    func mapping(map: Map) {
        count >>> map["count"]
        next >>> map["next"]
        previous >>> map["previous"]
        arrayPeople >>> map["results"]
    }
}
