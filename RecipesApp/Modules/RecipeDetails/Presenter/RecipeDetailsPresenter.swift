//
//  RecipeDetailsRecipeDetailsPresenter.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

class RecipeDetailsPresenter: RecipeDetailsModuleInput, RecipeDetailsViewOutput, RecipeDetailsInteractorOutput {
    
    private var recipeId = ""
    
    private var isAddedToFavorites = false
    
    private var loadedRecipe: Recipe?
    
    weak var view: RecipeDetailsViewInput!
    var interactor: RecipeDetailsInteractorInput!
    var router: RecipeDetailsRouterInput!

    func viewIsReady() {
        loadData()
    }
    
    func setup(recipeId: String) {
        self.recipeId = recipeId
    }
    
    private func loadData() {
        view.showLoading()
        interactor.loadRecipe(withId: recipeId)
    }
    
    func didFinishLoadRecipe(result: InteractorFetchResult<Recipe>, isAddedToFavorites: Bool) {
        view.hideLoading()
        loadedRecipe = result.resultItem
        
        if let recipe = loadedRecipe {
            view.set(viewModel: viewModel(fromRecipe: recipe))
        } else if result.requestResult.error != nil {
            view.show(errorMessage: R.string.localizable.detailsError())
        }
        
        self.isAddedToFavorites = isAddedToFavorites
        
        if isAddedToFavorites {
            view.markAsAddedToFavorites()
        } else {
            view.markAsRemovedFromFavorites()
        }
    }
    
    func changeFavoriteStatus() {
        guard let recipe = loadedRecipe else {
            return
        }
        
        if isAddedToFavorites {
            interactor.removeFromFavorites(recipe: recipe)
            view.markAsRemovedFromFavorites()
        } else {
            interactor.addToFavorites(recipe: recipe)
            view.markAsAddedToFavorites()
        }
    }
    
    private func viewModel(fromRecipe recipe: Recipe) -> RecipeDetailsViewModel {
        let ingredients = recipe.ingredients.map({ "\($0.title) (\($0.measureValue))" }).joined(separator: "\n")
        return RecipeDetailsViewModel(name: recipe.preview.title,
                                      instructions: recipe.instructions,
                                      ingredients: ingredients,
                                      imageURL: recipe.preview.imageURL)
    }
}
