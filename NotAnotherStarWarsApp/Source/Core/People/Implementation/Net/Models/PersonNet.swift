//
//  PersonNet.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import ObjectMapper

struct PersonNet : Mappable {
    
    let name: String?
    let height: String?
    let mass: String?
    let hairColor: String?
    let skinColor: String?
    let eyeColor: String?
    let birthYear: String?
    let gender: String?
    let homeworld: String?
    let films : Array<String>?
    let species : Array<String>?
    let vehicles : Array<String>?
    let starships : Array<String>?
    let created: String?
    let edited: String?
    let url: String?
    
    init?(map: Map) {
        name = try? map.value("name")
        height = try? map.value("height")
        mass = try? map.value("mass")
        hairColor = try? map.value("hair_color")
        skinColor = try? map.value("skin_color")
        eyeColor = try? map.value("eye_color")
        birthYear = try? map.value("birth_year")
        gender = try? map.value("gender")
        homeworld = try? map.value("homeworld")
        films = try? map.value("films")
        species = try? map.value("species")
        vehicles = try? map.value("vehicles")
        starships = try? map.value("starships")
        created = try? map.value("created")
        edited = try? map.value("edited")
        url = try? map.value("url")
    }
    
    func mapping(map: Map) {
        name >>> map["name"]
        height >>> map["height"]
        mass >>> map["mass"]
        hairColor >>> map["hair_color"]
        skinColor >>> map["skin_color"]
        eyeColor >>> map["eye_color"]
        birthYear >>> map["birth_year"]
        gender >>> map["height"]
        homeworld >>> map["homeworld"]
        films >>> map["films"]
        species >>> map["species"]
        vehicles >>> map["vehicles"]
        starships >>> map["starships"]
        created >>> map["created"]
        edited >>> map["edited"]
        url >>> map["url"]
    }
}
