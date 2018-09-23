//
//  RecipesListRecipesListInitializer.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class RecipesListModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var recipeslistViewController: RecipesListViewController!

    override func awakeFromNib() {

        let configurator = RecipesListModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: recipeslistViewController)
    }

}
