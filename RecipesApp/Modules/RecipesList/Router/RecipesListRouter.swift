//
//  RecipesListRecipesListRouter.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

class RecipesListRouter: Router , RecipesListRouterInput {

    func showRecipeDetails(recipeId: String) {
        navigator?.navigate(withSegueId: R.segue.recipesListViewController.showRecipeDetails.identifier,
                            type: RecipeDetailsModuleInput.self,
                            setupHandler: { (input) in
                                input.setup(recipeId: recipeId)
        })
    }
    
}
