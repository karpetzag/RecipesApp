//
//  RecipeDetailsRecipeDetailsInteractor.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

class RecipeDetailsInteractor: RecipeDetailsInteractorInput {
    
    private let recipeService: RecipesService
    private let favoriteRecipesService: FavoriteRecipesService
    private let cache: RecipesLocalStorage

    init(recipeService: RecipesService, favoriteRecipesService: FavoriteRecipesService, cache: RecipesLocalStorage) {
        self.favoriteRecipesService = favoriteRecipesService
        self.recipeService = recipeService
        self.cache = cache
    }
    
    weak var output: RecipeDetailsInteractorOutput!

    func loadRecipe(withId id: String) {
        recipeService.loadRecipe(withId: id) { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            
            var cachedRecipe: Recipe?
            if let recipe = result.resultItem {
                self.cache.update(recipe: recipe)
            } else {
                cachedRecipe = self.cache.load(recipeId: id)
            }
            
            let interactorResult = InteractorFetchResult(requestResult: result, cachedContent: cachedRecipe)
            self.output.didFinishLoadRecipe(result: interactorResult,
                                                isAddedToFavorites: self.favoriteRecipesService.isAddedToFavorite(recipeId: id))
        }
    }
    
    func addToFavorites(recipe: Recipe) {
        favoriteRecipesService.add(recipe: recipe)
    }
    
    func removeFromFavorites(recipe: Recipe) {
        favoriteRecipesService.remove(recipe: recipe)
    }
}
