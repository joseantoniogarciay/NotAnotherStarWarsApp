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
    
    func getPeople(completion: @escaping ((Bool, [Person]?, Error?) -> Void)) -> Int {
        let methodUrl = String(format: netSupport.api.PEOPLE)
        let dicHeader = ["Accept" : "application/json"]
        
        let request = netSupport.getRequestGenerator()
            .method(.get).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .build()
        /*
        do {
            let response: PagePeopleNet = try netSupport.netJsonMappableRequest(request)
            return try PeopleParser.parsePagePeople(response)
        } catch is NetError {
            throw PeopleError.net
        }*/
        
        return netSupport.netJsonMappableRequest(request, completion: { (result, pagePeopleNet:PagePeopleNet?, error) in
            //TODO: Parser
            do {
                guard let peopleNet = pagePeopleNet else { completion(false, nil, PeopleError.net); return }
                let arrayPerson : [Person] = try PeopleParser.parsePagePeople(peopleNet)
                completion(true, arrayPerson, nil)
            } catch {
               completion(false, nil, PeopleError.net)
            }
        })
        
        
    }
    
    
    func uploadArchives(uploadUrl: String, otherParameters:[String: String], auth : Bool, archives: [FormData], actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Bool, Person?, Error?) -> Void)) -> Int {
        return netSupport.netUploadArchives(uploadUrl: "", otherParameters: [:], auth: true, archives: [],
        actualProgress: { progress in
        
        },
        completion: { (bool, response:PersonNet?, error) in
            //TODO: Parser
            let person = Person.Builder()
                .setName("")
                .setHeight("")
                .setMass("")
                .build()
            completion(bool, person, error)
        })
    }
    
}
