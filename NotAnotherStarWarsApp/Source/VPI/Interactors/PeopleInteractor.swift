//
//  PeopleInteractor.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Kommander

class PeopleInteractor {
    
    let kommander = Kommander()
    
    func getPeople() -> Kommand<[Person]> {
        return kommander.makeKommand { () -> [Person] in
            do {
                return try DependencyProvider.people.getPeople()
            } catch let error as PeopleError {
                throw error
            }
        }
    }
    
    
    func getDetailTitle() -> Kommand<String> {
        return kommander.makeKommand { () -> String in
            sleep(3)
            return("Detail")
        }
    }

}
