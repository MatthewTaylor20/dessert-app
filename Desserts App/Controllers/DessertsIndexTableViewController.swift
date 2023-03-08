//
//  DessertsIndexTableViewController.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import UIKit

class DessertsIndexTableViewController: UITableViewController{
    //initializes a desserts array to store the data for the TableView
    var desserts: [DessertModel] = [] {
        didSet {
            //When the desserts array changes, the TableView is reloaded.
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //On initial load, this removes the spinner from the background of the TableView
                self.spinner.stopAnimating()
            }
            print("tableViewGroups")
        }
    }
    //selectedDessert will eventually store the recipe id of the cell clicked in the TableView to be passed to the DessertsShowViewController
    var selectedDessert: String?
    var dessertManager = DessertManager()
    //initialize the activity indicator
    let spinner = UIActivityIndicatorView(style: .medium)


    override func viewDidLoad() {
        super.viewDidLoad()
        //activity indicator shows until the TableView is reloaded with desserts array
        spinner.startAnimating()
        tableView.backgroundView = spinner
        spinner.hidesWhenStopped = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        //TableView customization and registering TableViewCell
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 180.0
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "recipieCell")
        
        //declares self to be DessertManager delegate and calls the method to start the network request for desserts array data
        dessertManager.delegate = self
        dessertManager.fetchDessertData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desserts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //setting the elements of the custom cell to render the data from the desserts array
        let dessert = desserts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipieCell", for: indexPath) as! TableViewCell
        cell.dessertLabel.text = dessert.name
        cell.dessertImageView.load(url: dessert.imageURL)
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selecting a cell sets the selectedDesserts property to be the recipe id
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        selectedDessert = desserts[indexPath.row].iD
        performSegue(withIdentifier: "showDessert", sender: cell)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //passes the recipe id to the receiving view controller in order to make the next appropriate network request
        if segue.identifier == "showDessert" {
            let receiverVC = segue.destination as! DessertsShowViewController
            receiverVC.recipeID = selectedDessert
        }
    }


}

//MARK: - DessertManagerDelegate
extension DessertsIndexTableViewController: DessertManagerDelegate {
    func didUpdateDesserts(_ dessertManager: DessertManager, desserts: [DessertModel]) {
        //update the desserts property with the returned data from the network request started in viewDidLoad
        self.desserts = desserts
    }
    
    func didFailWithError(error: Error) {
        //if network request throws errors, those are printed to the console
        print(error)
    }
    
    
}

extension UIImageView {
    //allows the image view on each cell to download image from url and render in the image view
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


