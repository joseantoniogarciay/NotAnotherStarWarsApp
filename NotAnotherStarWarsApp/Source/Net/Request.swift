//
//  Request.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

struct Request {
    let url: String
    let method: Method
    let shouldCache: Bool
    let headers: Dictionary<String, String>
    let body: Body

    init?(builder: RequestBuilder) {
        if let url = builder.url, let method = builder.method, let shouldCache = builder.shouldCache,
           let headers = builder.headers, let body = builder.body {
            self.url = url
            self.method = method
            self.shouldCache = shouldCache
            self.headers = headers
            self.body = body
        } else {
            return nil
        }
    }
}

class RequestBuilder {
    var url: String?
    var method: Method?
    var shouldCache: Bool?
    var headers: Dictionary<String, String>?
    var body: Body?

    typealias BuilderClosure = (RequestBuilder) -> ()

    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}

struct Body {
    let parameterEncoding: ParameterEncoding
    let params: [String: AnyObject]?

    init(parameterEncoding: ParameterEncoding, params: [String: AnyObject]) {
        self.parameterEncoding = parameterEncoding
        self.params = params
    }
}

enum Method {
    case get,
    post,
    put,
    delete,
    head,
    options,
    trace,
    patch,
    connect
}

enum ParameterEncoding {
    case url, json, form
}
