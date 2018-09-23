//
//  CategoriesListCategoriesListInteractor.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

class CategoriesListInteractor {

    weak var output: CategoriesListInteractorOutput!

    private let recipesService: RecipesService
    private let cache: CategoryLocalStorage
    
    init(recipesService: RecipesService, cache: CategoryLocalStorage) {
        self.recipesService = recipesService
        self.cache = cache
    }
}

extension CategoriesListInteractor: CategoriesListInteractorInput {
    
    func loadCategories() {
        recipesService.loadCategories { [weak self] (result) in
            var cachedCategories: [Category]?
            if let categories = result.resultItem {
                self?.cache.update(withCategories: categories)
            } else {
                cachedCategories = self?.cache.load()
            }
            
            let fetchResult = InteractorFetchResult(requestResult: result, cachedContent: cachedCategories)

            self?.output.didLoadCategories(result: fetchResult)
        }
    }
    
}
