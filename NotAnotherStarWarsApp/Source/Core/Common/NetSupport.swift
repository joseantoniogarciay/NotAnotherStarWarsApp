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

    init(net: Net, api: Api) {
        self.net = net
        self.api = api
    }

    func getRequestGenerator() -> RequestGenerator {
        return RequestGenerator()
    }

    func netJsonMappableRequest<T:Convertible>(_ request: Request, completion: @escaping ((T?, NetError?) -> Void)) -> Int {
        return net.launchRequest(request, completion: { (netResponse, error) in
            guard let response = netResponse else { completion(nil, error); return }
            guard response.message != "" else {
                 completion(nil, NetError.emptyResponse)
                return
            }
            guard let object : T =  T.self.instance(response.message) else { completion(nil, NetError.mappingError); return }
            completion(object, nil)
        })
    }
    
    func netUploadArchives<T:Convertible>(_ request: Request, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((T?, NetError?) -> Void)) -> Int {
        return net.uploadRequest(request, archives: archives,
        actualProgress: { progress in
            actualProgress(progress)
        },
        completion: { (netResponse, error) in
            guard let response = netResponse else { completion(nil, error); return }
            guard response.message != "" else {
                completion(nil, NetError.emptyResponse)
                return
            }
            guard let object : T =  T.self.instance(response.message) else { completion(nil, NetError.mappingError); return }
            completion(object, nil)
        })
    }
    
}
