//
//  DessertManager.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import UIKit

protocol DessertManagerDelegate {
    func didUpdateDesserts(_ dessertManager: DessertManager, desserts: [DessertModel])
    func didFailWithError(error: Error)
}

struct DessertManager {
    let dessertsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    var delegate: DessertManagerDelegate?
    
    func fetchDessertData() {
        let urlString = dessertsURL
        performDessertRequest(with: urlString)
    }
    
    func performDessertRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let desserts = parseDessertJSON(safeData){
                        self.delegate?.didUpdateDesserts(self, desserts: desserts)
                    }
                }
            }
            task.resume()

        }
    }
    
    func parseDessertJSON(_ dessertData: Data) -> [DessertModel]? {
        var desserts: [DessertModel] = []
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DessertData.self, from: dessertData)
            decodedData.meals.forEach({ meal in
                let dessertName = meal.strMeal
                let dessertImageURl = URL(string: meal.strMealThumb)!
                let dessertID = meal.idMeal
                let dessert = DessertModel(name: dessertName, imageURL: dessertImageURl, iD: dessertID)
                desserts.append(dessert)
                
            })
            return desserts
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
