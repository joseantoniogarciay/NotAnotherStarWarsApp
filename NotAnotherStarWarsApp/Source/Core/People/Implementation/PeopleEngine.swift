//
//  PeopleEngine.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class PeopleEngine : PeopleProtocol {
    
    let netSupport: NetSupport
    
    init(netSupport: NetSupport) {
        self.netSupport = netSupport
    }
    
    func getPeople(completion: @escaping (([Person]?, Error?) -> Void)) -> Int {
        let methodUrl = String(format: netSupport.api.PEOPLE)
        let dicHeader = ["Accept" : "application/json"]
        
        let request = netSupport.getRequestGenerator()
            .method(.get).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .build()
        
        return netSupport.netJsonMappableRequest(request, completion: { (response:PagePeopleNet?, error) in
            guard let pagePeopleNet = response else {
                completion(nil, PeopleError.net(underlying: error))
                return
            }
            do {
                let arrayPerson : [Person] = try PeopleParser.parsePagePeople(pagePeopleNet)
                completion(arrayPerson, nil)
            } catch {
                completion(nil, PeopleError.parserError)
            }
        })
    }
    
    func uploadPhotos(_ photos: [Photo], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Person?, Error?) -> Void)) -> Int {
        let methodUrl = String(format: netSupport.api.UPLOAD)
        let dicHeader = ["Accept" : "application/json", "Content-Type" : "multipart/form-data"]
        
        let request = netSupport.getRequestGenerator()
            .method(.get).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .build()
        
        var arrayFormData : [FormData] = []
        for i in 0..<photos.count {
            arrayFormData.append(FormDataTransformer.transform(from: photos[i], apiName: "identifier\(i+1)"))
        }
        
        return netSupport.netUploadArchives(request, archives: arrayFormData,
        actualProgress: { progress in
            actualProgress(progress)
        },
        completion: { (response:PersonNet?, error) in
            guard let personNet = response else {
                completion(nil, PeopleError.net(underlying: error))
                return
            }
            do {
                let person : Person = try PeopleParser.parsePerson(personNet)
                completion(person, nil)
            } catch {
                completion(nil, PeopleError.parserError)
            }
        })
    }
    
    func testNetParams(objectTest: ObjectTest, completion: @escaping (([Person]?, Error?) -> Void)) -> Int {
        let methodUrl = String(format: netSupport.api.PEOPLE)
        let dicHeader = ["Accept" : "application/json"]
        
        let request = netSupport.getRequestGenerator()
            .method(.post).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .setParameterEncoding(.json)
            .addBody(params: ObjectTestNetTransformer.transform(from: objectTest).toJSONString())
            .build()
        
        return netSupport.netJsonMappableRequest(request, completion: { (response:PagePeopleNet?, error) in
            guard let pagePeopleNet = response else {
                completion(nil, PeopleError.net(underlying: error))
                return
            }
            do {
                let arrayPerson : [Person] = try PeopleParser.parsePagePeople(pagePeopleNet)
                completion(arrayPerson, nil)
            } catch {
                completion(nil, PeopleError.parserError)
            }
        })
    }

}
