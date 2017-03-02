//
//  JSONableObjectMapper.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONableObjectMapper : JSONable {
    
    func transform<T:Convertible>(_ source: String, toStruct: T.Type) throws -> T {
        guard let mappedObj : T = toStruct.instance(source) else {
            throw NetError.mappingError
        }
        return mappedObj
    }
    
}

