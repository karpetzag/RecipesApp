//
//  LocalStorageMocks.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 11/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp

class CategoryLocalStorageMock: CategoryLocalStorage {
    
    var categoriesToReturn = [RecipesApp.Category]()
    var updatedCategories = [RecipesApp.Category]()
    var isLoadCalled = false
    var isUpdateCalled = false
    
    func load() -> [RecipesApp.Category]? {
        isLoadCalled = true
        return categoriesToReturn
    }
    
    func update(withCategories categories: [RecipesApp.Category]) {
        isUpdateCalled = true
        updatedCategories = categories
    }
}

class MockRecipesLocalStorage: RecipesLocalStorage {
    
    var isUpdateRecipesCalled = false
    var isLoadRecipesCalled = false
    var isUpdateRecipeCalled = false
    var isLoadRecipeCalled = false
    
    var recipeToReturn: Recipe?
    var recipesToReturn = [RecipePreview]()
    var updatedRecipes = [RecipePreview]()
    var updatedRecipe: Recipe?

    func update(recipes: [RecipePreview], categoryId: String) {
        self.updatedRecipes = recipes
        isUpdateRecipesCalled = true
    }
    
    func load(categoryId: String) -> [RecipePreview]? {
        isLoadRecipesCalled = true
        return recipesToReturn
    }
    
    func update(recipe: Recipe) {
        updatedRecipe = recipe
        isUpdateRecipeCalled = true
    }
    
    func load(recipeId: String) -> Recipe? {
        isUpdateRecipeCalled = true
        return recipeToReturn
    }
    
}
