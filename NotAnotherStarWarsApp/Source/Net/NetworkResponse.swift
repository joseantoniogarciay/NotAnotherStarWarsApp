//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//
import Foundation

struct NetworkResponse
{
    let statusCode: Int
    let message: String
    let headers: Dictionary<String, String>

    init(statusCode: Int) {
        self.init(statusCode: statusCode, message: "", headers: [:])
    }

    init(statusCode: Int, message: String, headers: Dictionary<String, String>) {
        self.statusCode = statusCode
        self.message = message
        self.headers = headers
    }
}
