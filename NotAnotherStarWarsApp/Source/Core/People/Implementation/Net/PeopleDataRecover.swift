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
    
    func uploadPhotos(archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Person?, Error?) -> Void)) -> Int {
        let methodUrl = String(format: netSupport.api.UPLOAD)
        let dicHeader = ["Accept" : "application/json", "Content-Type" : "multipart/form-data"]
        
        guard let request = netSupport.getRequestGenerator()
            .method(.get).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .build()
            else { return -1 }
        
        return netSupport.netUploadArchives(request, archives: archives,
        actualProgress: { progress in
        
        },
        completion: { (response:PersonNet?, error) in
            //TODO: Parser
            let person = Person.Builder()
                .setName("")
                .setHeight("")
                .setMass("")
                .build()
            completion(person, error)
        })
    }
    
}
