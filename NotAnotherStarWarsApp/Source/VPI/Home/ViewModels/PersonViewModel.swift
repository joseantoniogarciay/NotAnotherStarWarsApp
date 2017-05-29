//
//  PersonViewModel.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 29/05/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

class PersonViewModel: NSObject {
    let person: Person
    var loading: Bool
    
    init(person: Person) {
        self.person = person
        loading = false
    }

}
