//
//  RecipesListRecipesListInteractorTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class RecipesListInteractorTests: XCTestCase {

    private var interactor: RecipesListInteractor!
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
        interactor = RecipesListInteractor(recipeService: mockRecipesService,
                                           cache: mockRecipesLocalStorage,
                                           favoriteRecipesService: mockFavoriteService)
        interactor.output = mockPresenter
    }

    func testWhenRecipeIsAddedToFavotitesNotifyPresenter()  {
        let recipe = Recipe.testRecipes(count: 1).first!
        interactor.startObserveFavoriteStatusChange()
        interactor.didAddToFavorites(recipe: recipe)
        XCTAssertTrue(mockPresenter.didAddRecipeToFavoritesCalled)
    }
    
    func testWhenRecipeIsRemovedToFavotitesNotifyPresenter()  {
        let recipe = Recipe.testRecipes(count: 1).first!
        interactor.startObserveFavoriteStatusChange()
        interactor.didRemoveFromFavorites(recipe: recipe)
        XCTAssertTrue(mockPresenter.didRemoveRecipeFromFavorites)
    }
    
    func testAfterFailedResultLoadCachedData() {
        let category = RecipesApp.Category.testCategory()
        mockRecipesService.previewResult = .failure(ApiInternalError.unknown)
        let previews = RecipePreview.testPreviews(count: 10)
        mockRecipesLocalStorage.recipesToReturn = previews
        
        interactor.loadAllRecipes(category: category)
        
        XCTAssertEqual(mockPresenter.result.cachedContent!, previews)
    }
    
    func testAfterSuccessResponseUseDataFromService() {
        let category = RecipesApp.Category.testCategory()
        let previews = RecipePreview.testPreviews(count: 10)
        mockRecipesService.previewResult = .success(previews)
        interactor.loadAllRecipes(category: category)

        XCTAssertEqual(mockPresenter.result.resultItem!, previews)
    }

    func testAfterSuccessResponseUpdateDataInCache() {
        let category = RecipesApp.Category.testCategory()
        let previews = RecipePreview.testPreviews(count: 10)
        mockRecipesService.previewResult = .success(previews)
        interactor.loadAllRecipes(category: category)

        XCTAssertEqual(mockRecipesLocalStorage.updatedRecipes, previews)
    }

    class MockPresenter: RecipesListInteractorOutput {
        var didAddRecipeToFavoritesCalled = false
        var didRemoveRecipeFromFavorites = false
        var result: InteractorFetchResult<[RecipePreview]>!
        
        func didFinishLoadAllRecipes(result: InteractorFetchResult<[RecipePreview]>) {
            self.result = result
        }
        
        func didAddRecipeToFavorites(recipe: RecipePreview) {
            didAddRecipeToFavoritesCalled = true
        }
        
        func didRemoveRecipeFromFavorites(recipe: RecipePreview) {
            didRemoveRecipeFromFavorites = true
        }

    }
}
