//
//  PersonTableViewCell.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 8/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Reusable
import NVActivityIndicatorView

class PersonTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    weak var personVM : PersonViewModel?
    
    override func awakeFromNib() {
        activityIndicator.color = .black
        activityIndicator.type = .ballClipRotate
    }
    
    override func prepareForReuse() {
        activityIndicator.stopAnimating()
    }
    
    func updateWithPerson(_ personVM: PersonViewModel) {
        self.personVM = personVM
        nameLabel.text = personVM.person.name
        if let mass = personVM.person.mass {
            massLabel.text = mass + " kg"
        }
        if let height = personVM.person.height {
            heightLabel.text = height + " cm"
        }
        
        if personVM.loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func startLoading() {
        personVM?.loading = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        personVM?.loading = false
        activityIndicator.stopAnimating()
    }
    
}
