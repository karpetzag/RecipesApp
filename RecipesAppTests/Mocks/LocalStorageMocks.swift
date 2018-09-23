//
//  LocalStorageMocks.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 11/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp

class CategoryLocalStorageMock : CategoryLocalStorage {
    
    var categoriesToReturn = [RecipesApp.Category]()
    var updatedCategories = [RecipesApp.Category]()

    var updateDidCall = false
    var loadDidCall = false
    
    func load() -> [RecipesApp.Category]? {
        loadDidCall = true
        return categoriesToReturn
    }
    
    func update(withCategories categories: [RecipesApp.Category]) {
        updateDidCall = true
        updatedCategories = categories
    }
}

class MockRecipesLocalStorage: RecipesLocalStorage {
    var recipesToReturn = [RecipePreview]()
    var updatedRecipes: [RecipePreview]!
    
    func update(recipes: [RecipePreview], categoryId: String) {
        self.updatedRecipes = recipes
    }
    
    func load(categoryId: String) -> [RecipePreview]? {
        return recipesToReturn
    }
    
    func update(recipe: Recipe) {
        
    }
    
    func load(recipeId: String) -> Recipe? {
        return nil
    }
    
}
