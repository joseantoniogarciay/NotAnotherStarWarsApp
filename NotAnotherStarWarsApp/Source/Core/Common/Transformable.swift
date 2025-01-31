//
//  Transformable.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 6/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

public protocol Transformable {
    
    associatedtype Origin
    associatedtype Target
    static func transform(from : Origin) -> Target?
    
}
