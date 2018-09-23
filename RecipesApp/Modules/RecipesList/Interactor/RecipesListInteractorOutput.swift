//
//  RecipesListRecipesListInteractorOutput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import Foundation

protocol RecipesListInteractorOutput: class {

    func didFinishLoadAllRecipes(result: InteractorFetchResult<[RecipePreview]>)
    
    func didAddRecipeToFavorites(recipe: RecipePreview)
    
    func didRemoveRecipeFromFavorites(recipe: RecipePreview)
}
