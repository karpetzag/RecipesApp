//
//  CategoriesListCategoriesListConfigurator.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class CategoriesListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? CategoriesListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: CategoriesListViewController) {
        let router = CategoriesListRouter()
        router.navigator = DefaultNavigatior(transitionHandler: viewController)
        
        let presenter = CategoriesListPresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = CategoriesListInteractor(recipesService: ServiceProvider.container.resolve(RecipesService.self)!,
                                                  cache: ServiceProvider.container.resolve(CategoryLocalStorage.self)!)
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
