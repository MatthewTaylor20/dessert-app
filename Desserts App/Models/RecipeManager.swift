//
//  DessertManager.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import UIKit

protocol RecipeManagerDelegate {
    func didUpdateRecipe(_ dessertManager: RecipeManager, recipe: RecipeModel)
    func didFailWithError(error: Error)
}

struct RecipeManager {
    let recipeURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    var delegate: RecipeManagerDelegate?
    
    func fetchRecipeData(_ recipeID: String) {
        let urlString = "\(recipeURL)\(recipeID)"
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
                    if let recipe = parseRecipeJSON(safeData){
                        self.delegate?.didUpdateRecipe(self, recipe: recipe)
                    }
                }
            }
            task.resume()

        }
    }
    
    func parseRecipeJSON(_ recipeData: Data) -> RecipeModel? {
        var recipe: RecipeModel
        let decoder = JSONDecoder()
        do {
            let recipeData = try decoder.decode(RecipeData.self, from: recipeData)
            let recipeID = recipeData.meals[0].idMeal
            let recipeName = recipeData.meals[0].strMeal
            let recipeImageURL = URL(string: recipeData.meals[0].strMealThumb)!
            let ingredientNames = [recipeData.meals[0].strIngredient1,
                                   recipeData.meals[0].strIngredient2,
                                   recipeData.meals[0].strIngredient3,
                                   recipeData.meals[0].strIngredient4,
                                   recipeData.meals[0].strIngredient5,
                                   recipeData.meals[0].strIngredient6,
                                   recipeData.meals[0].strIngredient7,
                                   recipeData.meals[0].strIngredient8,
                                   recipeData.meals[0].strIngredient9,
                                   recipeData.meals[0].strIngredient10,
                                   recipeData.meals[0].strIngredient11,
                                   recipeData.meals[0].strIngredient12,
                                   recipeData.meals[0].strIngredient13,
                                   recipeData.meals[0].strIngredient14,
                                   recipeData.meals[0].strIngredient15,
                                   recipeData.meals[0].strIngredient16,
                                   recipeData.meals[0].strIngredient17,
                                   recipeData.meals[0].strIngredient18,
                                   recipeData.meals[0].strIngredient19,
                                   recipeData.meals[0].strIngredient20,
            ]
            let ingredientMeasures = [recipeData.meals[0].strMeasure1,
                                      recipeData.meals[0].strMeasure2,
                                      recipeData.meals[0].strMeasure3,
                                      recipeData.meals[0].strMeasure4,
                                      recipeData.meals[0].strMeasure5,
                                      recipeData.meals[0].strMeasure6,
                                      recipeData.meals[0].strMeasure7,
                                      recipeData.meals[0].strMeasure8,
                                      recipeData.meals[0].strMeasure9,
                                      recipeData.meals[0].strMeasure10,
                                      recipeData.meals[0].strMeasure11,
                                      recipeData.meals[0].strMeasure12,
                                      recipeData.meals[0].strMeasure13,
                                      recipeData.meals[0].strMeasure14,
                                      recipeData.meals[0].strMeasure15,
                                      recipeData.meals[0].strMeasure16,
                                      recipeData.meals[0].strMeasure17,
                                      recipeData.meals[0].strMeasure18,
                                      recipeData.meals[0].strMeasure19,
                                      recipeData.meals[0].strMeasure20,
               ]
            var ingredients: String = ""
            for i in 1...20 {
                if ingredientNames[i-1] != "" && ingredientMeasures[i-1] != "" && ingredientNames[i-1] != nil && ingredientMeasures[i-1] != nil{
                    ingredients = ingredients + "\u{2022} \(ingredientNames[i-1]!): \(ingredientMeasures[i-1]!)\n"
                }
            }
            let instructions = recipeData.meals[0].strInstructions
            recipe = RecipeModel(name: recipeName, imageURL: recipeImageURL, iD: recipeID, ingredients: ingredients, instructions: instructions)
            return recipe
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
