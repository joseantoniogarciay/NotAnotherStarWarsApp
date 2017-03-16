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

    func launchRequest(_ request: Request, completion: @escaping ((Bool, NetworkResponse?, Error?) -> Void)) -> Int {
        if !request.shouldCache {
            self.manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        }
        return AlamoFireAdapter.adaptRequest(request, manager:self.manager, completion: completion)
    }
    
    func uploadArchives(uploadUrl: String, otherParameters:[String: String], auth : Bool, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Bool, NetworkResponse?, Error?) -> Void)) -> Int {
            var uploadRequest : Alamofire.Request!
            var url : URLRequest = try! URLRequest(url: URL(string:"https://api.ttpdev.io/core/user/identification_files")!, method: .patch, headers: ["Accept" : "application/json", "Content-Type" : "multipart/form-data"])
            if auth { url.addValue("98a4a833-507d-4a5f-9c03-59834c3b061b", forHTTPHeaderField: "Session-Token") }
            let group = DispatchGroup()
            group.enter()
            self.manager.upload(multipartFormData: { (multipartFormData) in
                for archive in archives {
                    multipartFormData.append(archive.data, withName: archive.apiName, fileName: archive.fileName, mimeType: archive.mimeType)
                }
                for (key, value) in otherParameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, with: url, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    uploadRequest = upload
                    group.leave()
                    upload.uploadProgress(closure: { (progress) in
                        NSLog("Progress: \(progress.fractionCompleted)")
                        actualProgress(progress.fractionCompleted)
                    })
                    upload.validate().responseString() { response in
                        var responseString = response.result.value
                        if (responseString == nil) {
                            responseString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as String?
                        }
                        let networkResponse = NetworkResponse(statusCode: 0 , message: responseString!, headers: [:])
                        completion(true, networkResponse, nil)
                    }
                case .failure(let encodingError):
                    //encodingFailure
                    group.leave()
                    completion(false, NetworkResponse(statusCode: 0 , message: "", headers: [:]), nil)
                }
            })
            group.wait()
        return (uploadRequest.task != nil) ? uploadRequest.task!.taskIdentifier : -1
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
