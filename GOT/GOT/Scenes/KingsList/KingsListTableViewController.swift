//
//  KingsListTableViewController.swift
//  GOT
//
//  Created by macadmin on 5/12/18.
//  Copyright © 2018 macadmin. All rights reserved.
//

import UIKit

class KingsListTableViewController: UITableViewController {

    var interactor: KingsListBusinessLogic!
    
    var kings = [KingViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVIPComponents()
        loadKings()
    }
    
    func setUpVIPComponents() {
        
        let dataStore = KingsListDataStore()
        let presenter = KingsListPresenter(view: self)
        interactor = KingsListInteractor(presenter: presenter, dataStore: dataStore)
    }
    
    func loadKings() {
        interactor.fetchKings()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! KingTableViewCell
        
        cell.configure(viewModel: kings[indexPath.row])
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension KingsListTableViewController: KingsListPresenterOutput {
    
    func handleError(message: String) {
        showDefaultAlertWith(title: "Error", message: message)
    }
    
    func showNoContent() {
        showDefaultAlertWith(title: "", message: "No content")
    }
    
    func update(kings: [KingViewModel]) {
        self.kings = kings
    }
}

extension UIViewController {
    
    func showDefaultAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

