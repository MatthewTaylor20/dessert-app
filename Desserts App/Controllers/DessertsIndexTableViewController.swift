//
//  DessertsIndexTableViewController.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import UIKit

class DessertsIndexTableViewController: UITableViewController {
    var desserts: [DessertModel] = [
        DessertModel(dessertName: "Apam balik", dessertImageURL: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!, dessertID: "53049"),
        DessertModel(dessertName: "Apple & Blackberry Crumble", dessertImageURL: URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!, dessertID: "52893"),
        DessertModel(dessertName: "Apple Frangipan Tart", dessertImageURL: URL(string: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")!, dessertID: "52768")
    ]
    var selectedDessert: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = .none

        self.tableView.rowHeight = 180.0
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "recipieCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return desserts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dessert = desserts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipieCell", for: indexPath) as! TableViewCell
        cell.dessertLabel.text = dessert.dessertName
        cell.dessertImageView.load(url: dessert.dessertImageURL)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        selectedDessert = desserts[indexPath.row].dessertID
        performSegue(withIdentifier: "showDessert", sender: cell)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDessert" {
            let receiverVC = segue.destination as! DessertsShowViewController
            receiverVC.dessertID = selectedDessert
        }
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
