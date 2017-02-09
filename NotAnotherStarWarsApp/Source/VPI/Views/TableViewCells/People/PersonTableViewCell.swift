//
//  PersonTableViewCell.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 8/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Reusable

class PersonTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        activityIndicator.stopAnimating()
    }
    
    func updateWithPerson(_ person: Person) {
        nameLabel.text = person.name
        if let mass = person.mass {
            massLabel.text = mass + " kg"
        }
        if let height = person.height {
            heightLabel.text = height + " cm"
        }
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
}
