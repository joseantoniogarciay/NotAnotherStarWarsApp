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
    
    internal func netRequest(_ request: Request) throws -> String {
        do {
            let netResponse = try net.launchRequest(request)
            return netResponse!.message
        } catch NetError.error(let statusCode, let message) {
            throw NetError.error(statusErrorCode: statusCode, errorMessage: message)
        } catch {
            throw NetError.error(statusErrorCode: 520, errorMessage: "Unknown")
        }
    }
}
