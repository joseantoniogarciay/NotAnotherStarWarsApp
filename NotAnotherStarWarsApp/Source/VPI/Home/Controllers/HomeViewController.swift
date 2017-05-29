//
//  HomeController.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 1/2/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit
import Reusable

protocol HomeViewControllerProtocol: class {
    func updatePeople(_ arrayPerson: [PersonViewModel])
    func showLoadingForPerson(_ person: PersonViewModel, show: Bool)
    func stopTableViewActivityIndicator()
}


class HomeViewController: BaseViewController, StoryboardSceneBased {
    
    static var sceneStoryboard = UIStoryboard(name: AppStoryboard.Home.rawValue, bundle: nil)
    var presenter : HomePresenterProtocol?
    var arrayPerson : Array<PersonViewModel>?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }
    
    override func configView() {
        tableView.register(cellType: PersonTableViewCell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        automaticallyAdjustsScrollViewInsets = false
        title = "Star Wars People"
        let backItem = UIBarButtonItem()
        backItem.title = .Home_Back
        navigationItem.backBarButtonItem = backItem
    }

}


// MARK: HomeViewControllerProtocol
extension HomeViewController : HomeViewControllerProtocol {
    
    func updatePeople(_ arrayPerson: [PersonViewModel]) {
        tableViewActivityIndicator.stopAnimating()
        self.arrayPerson = arrayPerson
        tableView.reloadData()
    }
    
    func showLoadingForPerson(_ person: PersonViewModel, show: Bool) {
        if let index = arrayPerson?.index(of: person) {
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PersonTableViewCell {
                show ? cell.startLoading() : cell.stopLoading()
            }
        }
    }
    
    func stopTableViewActivityIndicator() {
        tableViewActivityIndicator.stopAnimating()
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
        
        if let person = arrayPerson?[indexPath.item] {
            cell.updateWithPerson(person)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


// MARK: Tableview Delegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let arrayPerson = arrayPerson else { return }
        
        presenter?.selectedPerson(arrayPerson[indexPath.item])
    }
    
}
