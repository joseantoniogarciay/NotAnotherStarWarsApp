//
//  PrintProduction.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

// Disable print for production.

public func print(_ items: Any..., separator: String = "", terminator: String = "\n") {
    #if DEBUG
        Swift.print(items[0], separator:separator, terminator: terminator)
    #endif
}
