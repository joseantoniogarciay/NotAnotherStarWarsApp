//
//  AlamoFireAdapter.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import Alamofire

class AlamoFireAdapter {

    static func adaptRequest(_ request: Request, manager: Alamofire.SessionManager, completion: @escaping ((Bool, NetworkResponse, Error?) -> Void)) -> Int {
        let afResponse = manager.request(
                request.url,
                method: self.transformMethod(request.method),
                parameters:request.body.params,
                encoding: self.transformParameterEncoding(request.body.parameterEncoding),
                headers: request.headers).validate().responseString() { afResponse in
                
                    let netResponse = NetworkResponse(statusCode: 0, message: afResponse.result.value!, headers: [:])
                    completion(true, netResponse, nil)
                    
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

                            completion(true, NetworkResponse(statusCode: responseData.statusCode , message: responseString, headers: adaptedHeaders), nil)
                        }
                    case .failure(let error):
                        guard let statusCode = afResponse.response?.statusCode else {
                            completion(false, NetworkResponse(statusCode: 500, message: "", headers: [:]), NetError.error(statusErrorCode: 500, errorMessage: error.localizedDescription))
                            return
                        }
                        completion(false, NetworkResponse(statusCode: statusCode, message: "", headers: [:]), NetError.error(statusErrorCode: statusCode, errorMessage: error.localizedDescription))
                    }
                    
                
        }
        return (afResponse.task != nil) ? afResponse.task!.taskIdentifier : -1
        
    }

    internal static func transformMethod(_ method: Method) -> Alamofire.HTTPMethod {
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
