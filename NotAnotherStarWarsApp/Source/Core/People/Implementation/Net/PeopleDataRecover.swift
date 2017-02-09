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
    
    func getPeople() throws -> [Person] {
        let methodUrl = String(format: netSupport.api.PEOPLE)
        let dicHeader = ["Accept" : "application/json"]
        
        let request = netSupport.getRequestGenerator()
            .method(.get).setUrl(methodUrl)
            .setRequestHeader(dicHeader)
            .build()
        
        do {
            let response: PagePeopleNet = try netSupport.netJsonMappableRequest(request)
            return try PeopleParser.parsePagePeople(response)
        } catch is NetError {
            throw PeopleError.net
        }
    }
    
}
