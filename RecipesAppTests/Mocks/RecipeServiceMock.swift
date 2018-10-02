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
   
    var categoriesResult: Result<[RecipesApp.Category]>?
    var previewResult: Result<[RecipePreview]>?
    var recipeResult: Result<Recipe>?

    var isLoadCategoriesCalled = false
    var isLoadRecipesCalled = false
    var isLoadRecipeCalled = false

    func loadCategories(withCompletion completion: @escaping (Result<[RecipesApp.Category]>) -> ()) {
        isLoadCategoriesCalled = true
        if let result = categoriesResult {
            completion(result)
        }
        
    }
  
    func loadRecipePreviews(forCategory category: RecipesApp.Category, completion: @escaping (Result<[RecipePreview]>) -> ()) {
        isLoadRecipesCalled = true
        if let result = previewResult {
            completion(result)
        }
    }
    
    func loadRecipe(withId id: String, completion: @escaping (Result<Recipe>) -> ()) {
        isLoadRecipeCalled = true
        if let result = recipeResult {
            completion(result)
        }
    }
    
}
