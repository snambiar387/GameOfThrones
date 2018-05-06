//
//  KingsTableViewController.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import UIKit

class KingsTableViewController: UITableViewController {

    var presenter: KingsListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = KingsListPresenter(dataRetriever: WebServiceManager(), view: self)
        
        presenter.loadAllKings()
    }
   
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfKings()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! KingTableViewCell

        cell.configure(viewModel: presenter.king(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension KingsTableViewController: KingListPresenterOutput {
    
    func showError(message: String) {
        
        showDefaultAlert(with: "Error", message: message)
    }
    
    func showNoContent() {
        
        showDefaultAlert(with: "", message: "No content")

    }
    
    func updateKingsList() {
        print("Update")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension UIViewController {
    
    func showDefaultAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
