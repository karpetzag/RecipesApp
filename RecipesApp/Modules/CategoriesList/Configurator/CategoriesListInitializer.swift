//
//  CategoriesListCategoriesListInitializer.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit

class CategoriesListModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var categorieslistViewController: CategoriesListViewController!

    override func awakeFromNib() {

        let configurator = CategoriesListModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: categorieslistViewController)
    }

}
