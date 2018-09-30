//
//  RecipesListRecipesListInteractor.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//


class RecipesListInteractor: RecipesListInteractorInput {
     
    weak var output: RecipesListInteractorOutput!
    
    private let recipeService: RecipesService
    private let cache: RecipesLocalStorage
    private let favoriteRecipesService: FavoriteRecipesService

    init(recipeService: RecipesService, cache: RecipesLocalStorage, favoriteRecipesService: FavoriteRecipesService) {
        self.recipeService = recipeService
        self.cache = cache
        self.favoriteRecipesService = favoriteRecipesService
    }
    
    func loadAllRecipes(category: Category) {
        recipeService.loadRecipePreviews(forCategory: category) { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            
            var cachedRecipes: [RecipePreview]?
            if let recipes = result.resultItem {
                self.cache.update(recipes: recipes, categoryId: category.id)
            } else {
                cachedRecipes = self.cache.load(categoryId: category.id)
            }
            
            let interactorResult = InteractorFetchResult(requestResult: result, cachedContent: cachedRecipes)
            self.output.didFinishLoadAllRecipes(result: interactorResult)
        }
    }
    
    func isFavorite(recipe: RecipePreview) -> Bool {
        return favoriteRecipesService.isAddedToFavorite(recipeId: recipe.id)
    }
    
    func startObserveFavoriteStatusChange() {
        favoriteRecipesService.add(observer: self)
    }
}

extension RecipesListInteractor: FavoriteStatusObserver {
    
    func didRemoveFromFavorites(recipe: Recipe) {
        output.didRemoveRecipeFromFavorites(recipe: recipe.preview)
    }
    
    func didAddToFavorites(recipe: Recipe) {
        output.didAddRecipeToFavorites(recipe: recipe.preview)
    }
}
