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
    
    func testWhenFavoriteRecipeIsAddedObserversShouldBeNotified() {
        let recipe = Recipe(preview: RecipePreview(id: "1", title: "", imageURL: nil), instructions: "", ingredients: [])
        
        service.add(recipe: recipe)
        XCTAssertNotNil(observerMock.addedRecipe)
    }
    
    func testWhenFavoriteRecipeIsRemovedObserversShouldBeNotified() {
        let recipe = Recipe(preview: RecipePreview(id: "1", title: "", imageURL: nil), instructions: "", ingredients: [])
        
        service.remove(recipe: recipe)
        XCTAssertNotNil(observerMock.removedRecipe)
    }
    
    func testWhenFavoriteIsAddedShouldBeMarkedCorrectly() {
        let recipe = Recipe(preview: RecipePreview(id: "1", title: "", imageURL: nil), instructions: "", ingredients: [])
        
        service.add(recipe: recipe)
        XCTAssertTrue(service.isAddedToFavorite(recipeId: recipe.id))
    }
    
    func testWhenFavoriteIsRemovedShouldBeMarkedCorrectly() {
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
