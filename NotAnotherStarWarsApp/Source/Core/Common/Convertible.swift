//
//  Convertible.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 2/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

protocol Convertible {
    static func instance<T:Convertible>(_ JSONString: String) -> T?
    static func toJSONString() -> String?
}
