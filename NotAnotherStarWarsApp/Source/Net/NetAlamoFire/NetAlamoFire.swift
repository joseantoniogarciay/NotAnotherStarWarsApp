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
        #if DEBUG
            ResponseDetective.enable(inConfiguration: configuration)
        #endif
        self.manager = Alamofire.SessionManager(configuration: configuration)
        self.manager.session.configuration.timeoutIntervalForRequest = requestTimeout
        self.setupCaching()
    }

    func setupCaching() {
        let URLCache = Foundation.URLCache(memoryCapacity: DF_CACHE_SIZE, diskCapacity: 4 * DF_CACHE_SIZE, diskPath: nil)
        Foundation.URLCache.shared = URLCache
    }

    func launchRequest(_ request: Request, completion: @escaping ((NetworkResponse?, NetError?) -> Void)) -> Int {
        if !request.shouldCache {
            self.manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        }
        return AlamoFireAdapter.adaptRequest(request, manager:self.manager, completion: completion)
    }
    
    func uploadRequest(_ request: Request, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((NetworkResponse?, NetError?) -> Void)) -> Int {
        return AlamoFireAdapter.adaptUploadRequest(request, manager:self.manager, archives: archives, actualProgress:actualProgress, completion: completion)
    }

    func cancelTask(identifier: Int) {
        self.manager.session.getAllTasks { (tasks: [URLSessionTask]) in
            if let task = tasks.filter({ (task: URLSessionTask) -> Bool in
                return task.taskIdentifier == identifier
            }).first, task.state == .running {
                task.cancel()
            }
        }
    }
    
    func isReachable() -> Bool {
        return self.reachabilityManager.isReachable
    }
    
}
