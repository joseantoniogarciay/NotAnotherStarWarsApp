//
//  DependencyProvider.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 6/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class DependencyProvider {
    
    static let net : Net = NetAlamoFire()
    
    static let netSupport = NetSupport(net: DependencyProvider.net, api: Api(baseUrlDirectory: "http://swapi.co/api/"), jsonable: JSONableObjectMapper())
    
    static let people = PeopleEngine(peopleDataRecover: PeopleDataRecover(netSupport: DependencyProvider.netSupport))

}
