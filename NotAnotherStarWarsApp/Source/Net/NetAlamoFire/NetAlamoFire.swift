//
//  NetAlamoFire.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation
import Alamofire
import ResponseDetective

class NetAlamoFire : Net {
    let DF_CACHE_SIZE = 5 * 1024 * 1024

    let manager: Alamofire.SessionManager
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")!

    init(requestTimeout: TimeInterval = 20.0) {
        let configuration = URLSessionConfiguration.default
        ResponseDetective.enable(inConfiguration: configuration)
        self.manager = Alamofire.SessionManager(configuration: configuration)
        self.manager.session.configuration.timeoutIntervalForRequest = requestTimeout
        self.setupCaching()
    }

    func setupCaching() {
        let URLCache = Foundation.URLCache(memoryCapacity: DF_CACHE_SIZE, diskCapacity: 4 * DF_CACHE_SIZE, diskPath: nil)
        Foundation.URLCache.shared = URLCache
    }

    func launchRequest(_ request: Request) throws -> NetworkResponse {
        if !request.shouldCache {
            self.manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        }
        do {
            return try AlamoFireAdapter.adaptRequest(request, manager:self.manager)
        } catch {
            throw error
        }
    }
    
    func isReachable() -> Bool {
        return self.reachabilityManager.isReachable
    }
    
}
