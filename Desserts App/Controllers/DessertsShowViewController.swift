//
//  DessertsShowViewController.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import UIKit

class DessertsShowViewController: UIViewController{
    //outlets for view controller elements
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var recipeID: String?
    var recipeName: String?
    var recipeManager = RecipeManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeManager.delegate = self
        recipeManager.fetchRecipeData(recipeID!)
        recipeImageView.layer.cornerRadius = recipeImageView.frame.size.height/10

        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //returns the navigation bar title setting to prefersLargeTitles
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }


}
//MARK: - DessertsShowViewController
extension DessertsShowViewController: RecipeManagerDelegate{
    func didUpdateRecipe(_ dessertManager: RecipeManager, recipe: RecipeModel) {
        //updates the view components with relevent data returned from network request made in viewDidLoad
        print(recipe)
        recipeImageView.load(url: recipe.imageURL)
        DispatchQueue.main.async {
            self.recipeTitleLabel.text = recipe.name
            self.ingredientsLabel.text = recipe.ingredients
            self.descriptionLabel.text = recipe.instructions
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
