//
//  CategoriesListCategoriesListInteractorOutput.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import Foundation


protocol CategoriesListInteractorOutput: class {

    func didLoadCategories(result: InteractorFetchResult<[Category]>)
    
}
