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
    
    func getPeople(completion: @escaping (([Person]?, Error?) -> Void)) -> Kommand<[Int]> {
        return kommander.makeKommand { _ in
            return [DependencyProvider.people.getPeople(completion: { (response, error) in
                DispatchQueue.main.async {
                    completion(response, error)
                }
            })]
        }
    }
    
    
    func getDetailTitle() -> Kommand<String> {
        return kommander.makeKommand { () -> String in
            sleep(3)
            return("Detail")
        }
    }
    
    func uploadPhoto(actualProgress:@escaping ((Double) -> Void), completion: @escaping ((Person?, Error?) -> Void)) -> Kommand<Int> {
        return kommander.makeKommand { _ in
            return DependencyProvider.people.uploadArchives(uploadUrl: "", otherParameters: [:], auth: true, archives: [],
            actualProgress: { progress in
                DispatchQueue.main.async {
                   actualProgress(progress)
                }
            },
            completion: { (response, error) in
                DispatchQueue.main.async {
                    completion(response, error)
                }
            })
        }
    }
    
    func cancelTask(identifier: Int) {
        DependencyProvider.net.cancelTask(identifier: identifier)
    }

}
