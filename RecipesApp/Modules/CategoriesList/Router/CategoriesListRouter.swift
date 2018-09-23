//
//  CategoriesListCategoriesListRouter.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class CategoriesListRouter: Router, CategoriesListRouterInput {

    func showRecipes(forCategory category: Category) {
        navigator?.navigate(withSegueId: R.segue.categoriesListViewController.showRecipesList.identifier,
                            type: RecipesListModuleInput.self,
                            setupHandler: { (input) in
            input.setup(withCategory: category)
        })
    }
}
