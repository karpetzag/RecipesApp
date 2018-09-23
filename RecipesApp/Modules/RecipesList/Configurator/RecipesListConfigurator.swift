//
//  RecipesListRecipesListConfigurator.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class RecipesListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? RecipesListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: RecipesListViewController) {
        let router = RecipesListRouter()
        router.navigator = DefaultNavigatior(transitionHandler: viewController)
        let presenter = RecipesListPresenter()
        presenter.view = viewController
        presenter.router = router
 
        let interactor = RecipesListInteractor(recipeService: ServiceProvider.container.resolve(RecipesService.self)!,
                                               cache: ServiceProvider.container.resolve(RecipesLocalStorage.self)!,
                                               favoriteRecipesService: ServiceProvider.container.resolve(FavoriteRecipesService.self)!)
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
