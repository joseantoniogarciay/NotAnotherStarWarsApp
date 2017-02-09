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
    
    static var storyboard = UIStoryboard(name: "Home", bundle: nil)
    var presenter : HomePresenterProtocol?
    var arrayPerson : Array<Person>?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }
    
    override func dependencyInjection() {
        presenter = HomePresenter(homeVC: self)
    }
    
    override func configView() {
        tableView.register(cellType: PersonTableViewCell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        automaticallyAdjustsScrollViewInsets = false
        title = "Star Wars People"
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }

}


// MARK: HomePresenter Communication
extension HomeViewController {
    
    func updatePeople(_ arrayPerson: [Person]) {
        tableViewActivityIndicator.stopAnimating()
        self.arrayPerson = arrayPerson
        tableView.reloadData()
    }
    
    func showLoadingForPerson(_ person: Person, show: Bool){
        if let index = arrayPerson?.index(of: person) {
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PersonTableViewCell {
                show ? cell.startLoading() : cell.stopLoading()
            }
        }
    }
    
}

// MARK: Tableview Datasource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPerson?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PersonTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.updateWithPerson(arrayPerson![indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


// MARK: Tableview Delegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedPerson(arrayPerson![indexPath.item])
    }
    
}
