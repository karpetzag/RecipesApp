//
//  RecipesLocalStorageTests.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 29/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import XCTest
@testable import RecipesApp

class RecipesLocalStorageTests: XCTestCase {
    
    var storage: DefaultRecipesLocalStorage!
    var fileCacheMock: FileCacheMock!
    
    override func setUp() {
        super.setUp()
        
        fileCacheMock = FileCacheMock()
        storage = DefaultRecipesLocalStorage(fileCache: fileCacheMock)
    }
    
    func testWhenSavePreviewsShouldUseFileCache() {
        let previews = RecipePreview.testPreviews(count: 10)
        storage.update(recipes: previews, categoryId: "")
        XCTAssertTrue(fileCacheMock.isAddContentCalled)
    }
    
    func testWhenSaveRecipeShouldUseFileCache() {
        let recipe = Recipe.testRecipe()
        storage.update(recipe: recipe)
        XCTAssertTrue(fileCacheMock.isAddContentCalled)
    }
    
    func testWhenLoadRecipeShouldUseFileCache() {
        let recipe = Recipe.testRecipe()
        let data = try! JSONEncoder().encode(recipe)
        fileCacheMock.contentToReturn = data
        let loadedRecipe = storage.load(recipeId: "123")
        XCTAssertEqual(loadedRecipe, recipe)
    }
    
    func testWhenLoadPreviewsShouldUseFileCache() {
        let previews = RecipePreview.testPreviews(count: 10)
        let data = try! JSONEncoder().encode(previews)
        fileCacheMock.contentToReturn = data
        let loadedPreviews = storage.load(categoryId: "")
        XCTAssertEqual(previews, loadedPreviews)
    }
}
