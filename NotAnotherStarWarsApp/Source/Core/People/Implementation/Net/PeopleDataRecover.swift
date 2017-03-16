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
        
        let request = netSupport.getRequestGenerator()
            .method(.get).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .build()
        
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
    
    
    func uploadArchives(uploadUrl: String, otherParameters:[String: String], auth : Bool, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Person?, Error?) -> Void)) -> Int {
        return netSupport.netUploadArchives(uploadUrl: "", otherParameters: [:], auth: true, archives: [],
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
