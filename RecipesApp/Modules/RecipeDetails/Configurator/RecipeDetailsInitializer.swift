//
//  RecipeDetailsRecipeDetailsInitializer.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class RecipeDetailsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var recipedetailsViewController: RecipeDetailsViewController!

    override func awakeFromNib() {

        let configurator = RecipeDetailsModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: recipedetailsViewController)
    }

}
