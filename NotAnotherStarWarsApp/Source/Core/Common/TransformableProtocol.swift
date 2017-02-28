//
//  TransformableProtocol.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 6/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

public protocol TransformableProtocol {
    
    associatedtype T
    associatedtype U
    static func transform(with : T) -> U?
    
}
