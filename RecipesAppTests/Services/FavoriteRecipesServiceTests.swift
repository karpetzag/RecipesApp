//
//  FavoriteRecipesService.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import XCTest
@testable import RecipesApp

class FavoriteRecipesServiceTests: XCTestCase {
    
    private var service: DefaultFavoriteRecipesService!
    private var cache: FileCache!
    private var observerMock: FavoriteObserverMock!
    
    override func setUp() {
        super.setUp()
        cache = DefaultFileCache()
        service = DefaultFavoriteRecipesService(fileCache: cache)
        observerMock = FavoriteObserverMock()
        service.add(observer: observerMock)
    }
    
    func testWhenFavoriteRecipeIsAddedObserversGetNotified() {
        let recipe = Recipe(preview: RecipePreview(id: "1", title: "", imageURL: nil), instructions: "", ingredients: [])
        
        XCTAssertNil(observerMock.addedRecipe)
        
        service.add(recipe: recipe)
        
        XCTAssertNotNil(observerMock.addedRecipe)
    }
    
    func testWhenFavoriteRecipeIsRemovedObserversGetNotified() {
        let recipe = Recipe(preview: RecipePreview(id: "1", title: "", imageURL: nil), instructions: "", ingredients: [])
        
        XCTAssertNil(observerMock.addedRecipe)
        
        service.remove(recipe: recipe)
        
        XCTAssertNotNil(observerMock.removedRecipe)
    }
    
    func testWhenFavoriteIsAddedItMarkedCorrectly() {
        let recipe = Recipe(preview: RecipePreview(id: "1", title: "", imageURL: nil), instructions: "", ingredients: [])
        
        service.add(recipe: recipe)
        
        XCTAssertTrue(service.isAddedToFavorite(recipeId: recipe.id))
    }
    
    func testWhenFavoriteIsRemovedItMarkedCorrectly() {
        let recipe = Recipe(preview: RecipePreview(id: "1", title: "", imageURL: nil), instructions: "", ingredients: [])
        
        service.add(recipe: recipe)
        service.remove(recipe: recipe)
        
        XCTAssertFalse(service.isAddedToFavorite(recipeId: recipe.id))
    }
    
    class FavoriteObserverMock: FavoriteStatusObserver {
        
        var addedRecipe: Recipe?
        var removedRecipe: Recipe?
        
        func didAddToFavorites(recipe: Recipe) {
            addedRecipe = recipe
        }
        
        func didRemoveFromFavorites(recipe: Recipe) {
            removedRecipe = recipe
        }
    }
}
