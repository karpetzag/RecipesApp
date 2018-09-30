//
//  RecipeDetailsRecipeDetailsPresenterTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class RecipeDetailsPresenterTest: XCTestCase {

    var presenter: RecipeDetailsPresenter!
    var routerMock: MockRouter!
    var interactorMock: MockInteractor!
    var viewMock: MockViewController!
    
    override func setUp() {
        super.setUp()
        interactorMock = MockInteractor()
        viewMock = MockViewController()
        routerMock = MockRouter()
        presenter = RecipeDetailsPresenter()
        presenter.router = routerMock
        presenter.view = viewMock
        presenter.interactor = interactorMock
    }

    func testWhenRecipeIsRemovedFromFavoritesShouldUpdateView() {
        let result = InteractorFetchResult(requestResult: .success(Recipe.testRecipe()), cachedContent: nil)
        presenter.didFinishLoadRecipe(result: result, isAddedToFavorites: true)
        presenter.changeFavoriteStatus()
        XCTAssertTrue(viewMock.isMarkAsRemovedFromFavoritesCalled)
    }
    
    func testWhenRecipeIsAddedToFavoritesShouldUpdateView() {
        let result = InteractorFetchResult(requestResult: .success(Recipe.testRecipe()), cachedContent: nil)
        presenter.didFinishLoadRecipe(result: result, isAddedToFavorites: false)
        presenter.changeFavoriteStatus()
        XCTAssertTrue(viewMock.isMarkAsAddedToFavoritesCalled)
    }
    
    func testWhenRecipeIsLoadedShouldSetCorrectViewModel() {
        let firstRecipesIngredient = RecipesIngredient(title: "First", measureValue: "100")
        let secondRecipesIngredient = RecipesIngredient(title: "Second", measureValue: "200")
        let ingredients = [firstRecipesIngredient, secondRecipesIngredient]
        let recipe = Recipe.testRecipe(title: "Title",
                                       imageURL: URL(string: "http://google.com"),
                                       instructions: "Recipe description", ingredients: ingredients)
        let result = InteractorFetchResult(requestResult: .success(recipe), cachedContent: nil)
        presenter.didFinishLoadRecipe(result: result, isAddedToFavorites: false)
        
        let vm = viewMock.addedViewModel!
        
        let expectedIngredients = "\(firstRecipesIngredient.title) (\(firstRecipesIngredient.measureValue))\n" +
        "\(secondRecipesIngredient.title) (\(secondRecipesIngredient.measureValue))"
        
        XCTAssertEqual(vm.imageURL, recipe.preview.imageURL)
        XCTAssertEqual(vm.name, recipe.preview.title)
        XCTAssertEqual(vm.instructions, recipe.instructions)
        XCTAssertEqual(vm.ingredients, expectedIngredients)
    }
    
    func testWhenViewIsReadyShouldStartLoadData() {
        presenter.viewIsReady()
        XCTAssertTrue(interactorMock.isLoadRecipeCalled)
    }
    
    func testWhenRecipeIsAddedToFavoritesShouldCallInteractor() {
        let result = InteractorFetchResult(requestResult: .success(Recipe.testRecipe()), cachedContent: nil)
        presenter.didFinishLoadRecipe(result: result, isAddedToFavorites: false)
        presenter.changeFavoriteStatus()
        
        XCTAssertTrue(interactorMock.isAddToFavoritesCalled)
    }
    
    func testWhenRecipeIsRemovedFromFavoritesShouldCallInteractor() {
        let result = InteractorFetchResult(requestResult: .success(Recipe.testRecipe()), cachedContent: nil)
        presenter.didFinishLoadRecipe(result: result, isAddedToFavorites: true)
        presenter.changeFavoriteStatus()
        
        XCTAssertTrue(interactorMock.isRemoveFromFavoritesCalled)
    }
    
    class MockInteractor: RecipeDetailsInteractorInput {
        
        var isLoadRecipeCalled = false
        var isAddToFavoritesCalled = false
        var isRemoveFromFavoritesCalled = false
        
        func loadRecipe(withId id: String) {
            isLoadRecipeCalled = true
        }
        
        func addToFavorites(recipe: Recipe) {
            isAddToFavoritesCalled = true
        }
        
        func removeFromFavorites(recipe: Recipe) {
            isRemoveFromFavoritesCalled = true
        }
    }

    class MockRouter: RecipeDetailsRouterInput {

    }

    class MockViewController: BaseViewMock, RecipeDetailsViewInput {
        var isMarkAsAddedToFavoritesCalled = false
        var isMarkAsRemovedFromFavoritesCalled = false
        var addedViewModel: RecipeDetailsViewModel?
        
        func markAsAddedToFavorites() {
            isMarkAsAddedToFavoritesCalled = true
        }
        
        func markAsRemovedFromFavorites() {
            isMarkAsRemovedFromFavoritesCalled = true
        }
        
        func set(viewModel: RecipeDetailsViewModel) {
            addedViewModel = viewModel
        }
    }
}
