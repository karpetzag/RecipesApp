//
//  RecipeServiceMock.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 11/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp

class RecipesServiceMock: RecipesService {
   
    var categoriesResult: DataResult<[RecipesApp.Category]>?
    var previewResult: DataResult<[RecipePreview]>?
    
    var loadCategoriesDidCall = false
    var loadRecipesDidCall = false
    
    func loadCategories(withCompletion completion: @escaping (DataResult<[RecipesApp.Category]>) -> ()) {
        loadCategoriesDidCall = true
        if let result = categoriesResult {
            completion(result)
        }
        
    }
  
    func loadRecipePreivews(forCategory category: RecipesApp.Category, completion: @escaping (DataResult<[RecipePreview]>) -> ()) {
        loadRecipesDidCall = true
        if let result = previewResult {
            completion(result)
        }
    }
    
    func loadRecipe(withId id: String, completion: @escaping (DataResult<Recipe>) -> ()) {
        
    }
    
}
