//
//  RecipesListRecipesListInteractorInput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import Foundation
 
protocol RecipesListInteractorInput {

    func loadAllRecipes(category: Category)
    
    func isFavorite(recipe: RecipePreview) -> Bool
    
    func startObserveFavoriteStatusChange()
}
