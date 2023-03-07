//
//  DessertsShowViewController.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import UIKit

class DessertsShowViewController: UIViewController{
    
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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - DessertsShowViewController
extension DessertsShowViewController: RecipeManagerDelegate{
    func didUpdateRecipe(_ dessertManager: RecipeManager, recipe: RecipeModel) {
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
