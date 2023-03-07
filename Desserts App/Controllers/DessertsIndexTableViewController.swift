//
//  DessertsIndexTableViewController.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import UIKit

class DessertsIndexTableViewController: UITableViewController{
    var desserts: [DessertModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
            print("tableViewGroups")
        }
    }
    var selectedDessert: String?
    var dessertManager = DessertManager()
    let spinner = UIActivityIndicatorView(style: .medium)


    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        tableView.backgroundView = spinner
        spinner.hidesWhenStopped = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = .none

        self.tableView.rowHeight = 180.0
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "recipieCell")
        
        dessertManager.delegate = self
        dessertManager.fetchDessertData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return desserts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dessert = desserts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipieCell", for: indexPath) as! TableViewCell
        cell.dessertLabel.text = dessert.name
        cell.dessertImageView.load(url: dessert.imageURL)
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        selectedDessert = desserts[indexPath.row].iD
        performSegue(withIdentifier: "showDessert", sender: cell)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDessert" {
            let receiverVC = segue.destination as! DessertsShowViewController
            receiverVC.recipeID = selectedDessert
        }
    }


}

//MARK: - DessertManagerDelegate
extension DessertsIndexTableViewController: DessertManagerDelegate {
    func didUpdateDesserts(_ dessertManager: DessertManager, desserts: [DessertModel]) {
        self.desserts = desserts
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


