//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_Synchronous
import ObjectMapper

class AlamoFireAdapter {

    static func adaptRequest(_ request: Request, manager: Alamofire.SessionManager) throws -> NetworkResponse! {
        let afResponse = manager.request(
                request.url,
                method: self.transformMethod(request.method),
                parameters:request.body.params,
                encoding: self.transformParameterEncoding(request.body.parameterEncoding),
                headers: request.headers).validate().responseString()

        switch afResponse.result {
        case .success(let responseString):
            if let responseData = afResponse.response {
                let headers = responseData.allHeaderFields

                var adaptedHeaders = [String:String]()
                for (headerKey, headerValue) in headers {
                    let key = headerKey as! String
                    let value = headerValue as! String
                    adaptedHeaders[key] = value
                }

                return NetworkResponse(statusCode: responseData.statusCode , message: responseString, headers: adaptedHeaders)
            }
        case .failure(let error):
            guard let statusCode = afResponse.response?.statusCode else {
                throw NetError.error(statusErrorCode: 500, errorMessage: error.localizedDescription)
            }
            throw NetError.error(statusErrorCode: statusCode, errorMessage: error.localizedDescription)
        }
        
        return nil
    }

    internal static func transformMethod(_ method: HTTPMethod) -> Alamofire.HTTPMethod {
        switch (method) {
        case .delete:
            return Alamofire.HTTPMethod.delete
        case .get:
            return Alamofire.HTTPMethod.get
        case .head:
            return Alamofire.HTTPMethod.head
        case .options:
            return Alamofire.HTTPMethod.options
        case .patch:
            return Alamofire.HTTPMethod.patch
        case .post:
            return Alamofire.HTTPMethod.post
        case .put:
            return Alamofire.HTTPMethod.put
        case .trace:
            return Alamofire.HTTPMethod.trace
        case .connect:
            return Alamofire.HTTPMethod.connect
        }
    }

    internal static func transformParameterEncoding(_ parameterEncoding: ParameterEncoding) -> Alamofire.ParameterEncoding {
        switch parameterEncoding {
        case .url:
            return Alamofire.URLEncoding.default
        case .json:
            return Alamofire.JSONEncoding.default
        case .form:
            return Alamofire.URLEncoding.default
        }
    }
}
