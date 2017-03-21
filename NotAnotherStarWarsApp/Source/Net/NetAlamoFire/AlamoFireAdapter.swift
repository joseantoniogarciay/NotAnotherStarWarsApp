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

    static func adaptRequest(_ request: Request, manager: Alamofire.SessionManager, completion: @escaping ((NetworkResponse?, NetError?) -> Void)) -> Int {
        let afResponse = manager.request(
                request.url,
                method: self.transformMethod(request.method),
                parameters:request.body.params,
                encoding: self.transformParameterEncoding(request.body.parameterEncoding),
                headers: request.headers).validate().responseString() { afResponse in
                    self.processResponse(afResponse: afResponse, completion: completion)
        }
        return (afResponse.task != nil) ? afResponse.task!.taskIdentifier : -1
    }
    
    static func adaptUploadRequest(_ request: Request, manager: Alamofire.SessionManager, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((NetworkResponse?, NetError?) -> Void)) -> Int {
        var uploadRequest : Alamofire.Request!
        var urlRequest : URLRequest!
        do {
            guard let url = URL(string: request.url) else { return -1 }
            urlRequest = try URLRequest(url: url, method: self.transformMethod(request.method), headers: request.headers)
        } catch {
            return -1
        }
        
        let group = DispatchGroup()
        group.enter()
        
        manager.upload(multipartFormData: { (multipartFormData) in
            for archive in archives {
                multipartFormData.append(archive.data, withName: archive.apiName, fileName: archive.fileName, mimeType: archive.mimeType)
            }
            for (key, value) in request.body.params {
                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, with: urlRequest, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                uploadRequest = upload
                group.leave()
                upload.uploadProgress(closure: { (progress) in
                    actualProgress(progress.fractionCompleted)
                })
                upload.validate().responseString() { afResponse in
                    self.processResponse(afResponse: afResponse, completion: completion)
                }
            case .failure:
                group.leave()
                completion(nil, NetError.encodingError)
            }
        })
        group.wait()
        return (uploadRequest.task != nil) ? uploadRequest.task!.taskIdentifier : -1
    }
    
    internal static func processResponse(afResponse: DataResponse<String>, completion: @escaping ((NetworkResponse?, NetError?) -> Void)) {
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
                
                completion(NetworkResponse(statusCode: responseData.statusCode , message: responseString, headers: adaptedHeaders), nil)
            } else {
                completion(nil, NetError.error(statusErrorCode: 500, errorMessage: ""))
            }
        case .failure(let error):
            guard let statusCode = afResponse.response?.statusCode else {
                completion(nil, NetError.error(statusErrorCode: 500, errorMessage: error.localizedDescription))
                return
            }
            completion(nil, NetError.error(statusErrorCode: statusCode, errorMessage: error.localizedDescription))
        }
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
