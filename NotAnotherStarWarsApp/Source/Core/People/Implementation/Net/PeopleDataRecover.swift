//
//  PeopleDataRecover.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 3/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class PeopleDataRecover {

    let netSupport: NetSupport
    
    init (netSupport: NetSupport) {
        self.netSupport = netSupport
    }
    
    func getPeople(completion: @escaping (([Person]?, Error?) -> Void)) -> Int {
        let methodUrl = String(format: netSupport.api.PEOPLE)
        let dicHeader = ["Accept" : "application/json"]
        
        guard let request = netSupport.getRequestGenerator()
            .method(.get).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .build()
            else { return -1 }
        
        return netSupport.netJsonMappableRequest(request, completion: { (pagePeopleNet:PagePeopleNet?, error) in
            do {
                guard let peopleNet = pagePeopleNet else { completion(nil, PeopleError.net); return }
                let arrayPerson : [Person] = try PeopleParser.parsePagePeople(peopleNet)
                completion(arrayPerson, nil)
            } catch {
               completion(nil, PeopleError.net)
            }
        })
    }
    
    func uploadPhotos(_ photos: [Photo], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Person?, Error?) -> Void)) -> Int {
        let methodUrl = String(format: netSupport.api.UPLOAD)
        let dicHeader = ["Accept" : "application/json", "Content-Type" : "multipart/form-data"]
        
        guard let request = netSupport.getRequestGenerator()
            .method(.get).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .build()
            else { return -1 }
        
        var arrayFormData : [FormData] = []
        for i in 0..<photos.count {
            arrayFormData.append(FormDataTransformer.transform(from: photos[i], apiName: "identifier\(i+1)"))
        }
        
        return netSupport.netUploadArchives(request, archives: arrayFormData,
        actualProgress: { progress in
        
        },
        completion: { (response:PersonNet?, error) in
            //TODO: Parser (real)
            let person = Person.Builder()
                .setName("")
                .setHeight("")
                .setMass("")
                .build()
            completion(person, error)
        })
    }
    
    func testNetParams(objectTest: ObjectTest, completion: @escaping (([Person]?, Error?) -> Void)) -> Int {
        let methodUrl = String(format: netSupport.api.PEOPLE)
        let dicHeader = ["Accept" : "application/json"]
        
        guard let request = netSupport.getRequestGenerator()
            .method(.post).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .setParameterEncoding(.json)
            .addBody(params: ObjectTestNetTransformer.transform(from: objectTest).toJSONString())
            .build()
            else { return -1 }
        
        return netSupport.netJsonMappableRequest(request, completion: { (pagePeopleNet:PagePeopleNet?, error) in
            do {
                guard let peopleNet = pagePeopleNet else { completion(nil, PeopleError.net); return }
                let arrayPerson : [Person] = try PeopleParser.parsePagePeople(peopleNet)
                completion(arrayPerson, nil)
            } catch {
                completion(nil, PeopleError.net)
            }
        })
    }
    
}
