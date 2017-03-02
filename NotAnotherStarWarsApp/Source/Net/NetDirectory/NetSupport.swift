//
//  NetSupport.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class NetSupport {
    let net: Net
    let api: Api
    let jsonable: JSONable

    init(net: Net, api: Api, jsonable: JSONable) {
        self.net = net
        self.api = api
        self.jsonable = jsonable
    }

    func getRequestGenerator() -> RequestGenerator {
        return RequestGenerator()
    }

    func netJsonMappableRequest<T:Convertible>(_ request: Request) throws -> T {
        let jsonStrResponse = try netRequest(request)
        guard jsonStrResponse != "" else {
            throw NetError.emptyResponse
        }
        return try jsonable.transform(jsonStrResponse, toStruct: T.self)
    }
    
    private func netRequest(_ request: Request) throws -> String {
        let netResponse = try net.launchRequest(request)
        return netResponse.message
    }
    
}
