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

    func netJsonMappableRequest<T:Convertible>(_ request: Request, completion: @escaping ((Bool, T?, Error?) -> Void)) -> Int {
        return net.launchRequest(request, completion: { (result, netResponse, error) in
            guard let response = netResponse else { completion(false, nil, error); return }
            guard response.message != "" else {
                 completion(false, nil, error)
                return
            }
            do {
                let object : T = try self.jsonable.transform(response.message, toStruct: T.self)
                completion(result, object, nil)
            } catch {
                completion(false, nil, error)
            }
            
        })
    }
    
    func netUploadArchives<T:Convertible>(uploadUrl: String, otherParameters:[String: String], auth : Bool, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Bool, T?, Error?) -> Void)) -> Int {
        return net.uploadArchives(uploadUrl: "", otherParameters: [:], auth: true, archives: [],
        actualProgress: { progress in
            actualProgress(progress)
        },
        completion: { (result, netResponse, error) in
            guard let response = netResponse else { completion(false, nil, error); return }
            do {
                let object : T = try self.jsonable.transform(response.message, toStruct: T.self)
                completion(result, object, nil)
            } catch {
                completion(false, nil, error)
            }
        })
    }
    
}
