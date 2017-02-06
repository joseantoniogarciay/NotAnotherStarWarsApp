//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import ObjectMapper

class NetSupport {
    let net: Net
    let api: Api

    init(net: Net, api: Api) {
        self.net = net
        self.api = api
    }

    func getRequestGenerator() -> RequestGenerator {
        return RequestGenerator()
    }

    func netJsonMappableRequest<T:Mappable>(_ request: Request) throws -> T {
        let jsonStrResponse = try netRequest(request)
        guard jsonStrResponse != "" else {
            throw NetError.emptyResponse
        }
        guard let mappedObj = Mapper<T>().map(JSONString: jsonStrResponse) else {
            throw NetError.mappingError
        }
        return mappedObj
    }
    
    private func netRequest(_ request: Request) throws -> String {
        let netResponse = try net.launchRequest(request)
        return netResponse!.message
    }
    
}
