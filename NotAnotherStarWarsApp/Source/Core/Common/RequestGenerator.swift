//
//  RequestGenerator.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class RequestGenerator {

    var requestUrl: String = ""
    var requestMethod: Method = .get
    var requestHeaders: Dictionary<String, String> = [:]
    var requestParams: Dictionary<String, AnyObject> = [:]
    var paramEncoding: ParameterEncoding = .url
    var shouldCache: Bool = true

    func setUrl(_ url: String) -> Self {
        self.requestUrl = url
        return self
    }
    
    func method(_ method: Method) -> Self {
        self.requestMethod = method
        return self
    }

    func addParameter(_ paramName: String, paramValue: String) -> Self {
        self.requestParams[paramName] = paramValue as AnyObject?
        return self
    }
    
    func addBody(params : String) -> Self {
        if let data = params.data(using: .utf8) {
            do {
                guard let dic =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    else { return self }
                self.requestParams = dic
            } catch {
                return self
            }
        }
        return self
    }

    func setParameterEncoding(_ parameterEncoding: ParameterEncoding) -> Self {
        self.paramEncoding = parameterEncoding
        return self
    }
    
    func setRequestHeader(_ dicRequestHeader : Dictionary<String, String>) -> Self{
        self.requestHeaders = dicRequestHeader
        return self
    }

    func setShouldCache(_ shouldCache: Bool) -> Self {
        self.shouldCache = shouldCache
        return self
    }

    func build () -> Request? {
        let requestData = RequestBuilder { builder in
            builder.url = self.requestUrl
            builder.method = self.requestMethod
            builder.headers = self.requestHeaders
            builder.body = Body(parameterEncoding: self.paramEncoding, params: self.requestParams)
            builder.shouldCache = self.shouldCache
        }
        return Request(builder:requestData)
    }

}
