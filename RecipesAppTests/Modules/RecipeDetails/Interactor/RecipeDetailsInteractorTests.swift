//
//  RecipeDetailsRecipeDetailsInteractorTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class RecipeDetailsInteractorTests: XCTestCase {

    private var interactor: RecipeDetailsInteractor!
    private var mockPresenter: MockPresenter!
    private var mockFavoriteService: MockFavoriteRecipesService!
    private var mockRecipesService: RecipesServiceMock!
    private var mockRecipesLocalStorage: MockRecipesLocalStorage!
    
    override func setUp() {
        super.setUp()
        
        mockRecipesLocalStorage = MockRecipesLocalStorage()
        mockFavoriteService = MockFavoriteRecipesService()
        mockRecipesService = RecipesServiceMock()
        
        mockPresenter = MockPresenter()
        interactor = RecipeDetailsInteractor(recipeService: mockRecipesService,
                                             favoriteRecipesService: mockFavoriteService,
                                             cache: mockRecipesLocalStorage)
        interactor.output = mockPresenter
    }

    func testWhenRecipeIsAddedToFavotitesShouldUseFavoriteService()  {
        let recipe = Recipe.testRecipe()
        interactor.addToFavorites(recipe: recipe)
        XCTAssertTrue(mockFavoriteService.isAddedToFavoritesCalled)
    }
    
    func testWhenRecipeIsRemovedFromFavotitesShouldUseFavoriteService()  {
        let recipe = Recipe.testRecipe()
        interactor.removeFromFavorites(recipe: recipe)
        XCTAssertTrue(mockFavoriteService.isRemovedFromFavoritesCalled)
    }
    
    func testWhenLoadIsFailedShouldUseCachedData() {
        let recipe = Recipe.testRecipe()
        mockRecipesService.recipeResult = .failure(ApiInternalError.unknown)
        mockRecipesLocalStorage.recipeToReturn = recipe
        
        interactor.loadRecipe(withId: "")
        XCTAssertEqual(mockPresenter.result!.cachedContent!, recipe)
    }
    
    func testWhenLoadIsSucceededShouldUseDataFromService() {
        let recipe = Recipe.testRecipe()
        mockRecipesService.recipeResult = .success(recipe)

        interactor.loadRecipe(withId: "")
        XCTAssertEqual(mockPresenter.result!.resultItem!, recipe)
    }

    func testWhenLoadIsSucceededShouldUpdateDataInCache() {
        let recipe = Recipe.testRecipe()
        mockRecipesService.recipeResult = .success(recipe)
        
        interactor.loadRecipe(withId: "")
        XCTAssertEqual(mockRecipesLocalStorage.updatedRecipe, recipe)
    }
    
    class MockPresenter: RecipeDetailsInteractorOutput {
        var result: InteractorFetchResult<Recipe>?
        
        func didFinishLoadRecipe(result: InteractorFetchResult<Recipe>, isAddedToFavorites: Bool) {
            self.result = result
        }
    }
}
