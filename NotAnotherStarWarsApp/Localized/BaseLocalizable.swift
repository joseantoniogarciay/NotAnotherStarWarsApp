//
//  BaseLocalizable.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 10/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

 
