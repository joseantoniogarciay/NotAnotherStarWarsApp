//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Reusable

class HomeViewController: BaseViewController, StoryboardSceneBased {
    
    enum SegueIdentifier: String {
        case PeopleDetail = "PeopleDetail"
    }
    
    static var storyboard = UIStoryboard(name: "Home", bundle: nil)
    var presenter : HomePresenterProtocol?
    var arrayPeople : Array<People>?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }
    
    override func dependencyInjection() {
        presenter = HomePresenter(homeVC: self)
    }
    
    override func configView() {
        tableView.register(cellType: PeopleTableViewCell.self)
        automaticallyAdjustsScrollViewInsets = false
        title = "Star Wars People"
    }

}


// MARK: HomePresenter Communication
extension HomeViewController {
    
    func updatePeople(arrayPeople: [People]) {
        self.arrayPeople = arrayPeople
        tableView.reloadData()
    }
    
}

// MARK: Tableview Datasource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPeople?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PeopleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.updateWithPerson(arrayPeople![indexPath.item])
        return cell
    }
    
}


// MARK: Tableview Delegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.PeopleDetail.rawValue, sender: indexPath)
    }
    
}

// MARK: Segue

extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.PeopleDetail.rawValue:
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            if let destinationVC = segue.destination as? PeopleDetailViewController, let indexPath = sender as? IndexPath {
                destinationVC.person = arrayPeople![indexPath.item]
                presenter?.wayToPersonDetail(destinationVC)
            }
            break
        default:
            break
        }
    }
    
}
