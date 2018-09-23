//
//  RecipeDetailsRecipeDetailsConfigurator.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class RecipeDetailsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? RecipeDetailsViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: RecipeDetailsViewController) {
        let router = RecipeDetailsRouter()

        let presenter = RecipeDetailsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = RecipeDetailsInteractor(recipeService: ServiceProvider.container.resolve(RecipesService.self)!,
                                                 favoriteRecipesService: ServiceProvider.container.resolve(FavoriteRecipesService.self)!,
                                                 cache: ServiceProvider.container.resolve(RecipesLocalStorage.self)!)
        
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
