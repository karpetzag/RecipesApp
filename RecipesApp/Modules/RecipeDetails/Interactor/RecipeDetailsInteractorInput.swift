//
//  RecipeDetailsRecipeDetailsInteractorInput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import Foundation

protocol RecipeDetailsInteractorInput {

    func loadRecipe(withId id: String)
    
    func addToFavorites(recipe: Recipe)
    
    func removeFromFavorites(recipe: Recipe)
}
