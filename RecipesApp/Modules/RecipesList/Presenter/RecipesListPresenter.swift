//
//  RecipesListRecipesListPresenter.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

class RecipesListPresenter: RecipesListModuleInput, RecipesListViewOutput {
   
    weak var view: RecipesListViewInput!
    var interactor: RecipesListInteractorInput!
    var router: RecipesListRouterInput!

    private var category: Category?
    private var recipes = [RecipePreview]()
 
    func viewIsReady() {
        view.setupInitialState()
        interactor.startObserveFavoriteStatusChange()
        
        view.showLoading()
        startLoadData()
    }
    
    func onViewRefesh() {
        startLoadData()
    }
    
    func setup(withCategory category: Category) {
        self.category = category
    }
    
    func didSelectRecipe(atIndex index: Int) {
        let recipe = recipes[index]
        router.showRecipeDetails(recipeId: recipe.id)
    }
    
    private func startLoadData() {
        guard let category = category else {
            return
        }
        interactor.loadAllRecipes(category: category)
    }
    
    private func reload(recipe: RecipePreview) {
        guard let index = recipes.index(where: { $0.id == recipe.id }) else {
            return
        }
        
        let vm = makeViewModel(fromRecipe: recipe)

        view.update(viewModel: vm, atIndex: index)
    }
    
    private func makeViewModel(fromRecipe recipe: RecipePreview) -> RecipePreviewViewModel {
        return RecipePreviewViewModel(title: recipe.title,
                                      previewURL: recipe.imageURL,
                                      isFavorite: interactor.isFavorite(recipe: recipe))
    }
}

extension RecipesListPresenter: RecipesListInteractorOutput {
    func didFinishLoadAllRecipes(result: InteractorFetchResult<[RecipePreview]>) {
        view.hideLoading()
        
        if let items = result.resultItem {
            self.recipes = items
            let viewModels = items.map(makeViewModel)
            view.endUpdate(withRecipes: viewModels)
        } else if result.requestResult.error != nil {
            view.endUpdate(withRecipes: [])
            view.show(errorMessage: R.string.localizable.recipesListError())
        }
    }
   
    func didAddRecipeToFavorites(recipe: RecipePreview) {
        reload(recipe: recipe)
    }
    
    func didRemoveRecipeFromFavorites(recipe: RecipePreview) {
        reload(recipe: recipe)
    }
}
