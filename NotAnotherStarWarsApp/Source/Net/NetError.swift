//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

enum NetError : Error {
    case error(statusErrorCode: Int, errorMessage: String)
    case emptyResponse
    case mappingError
    case nullResponse
}
