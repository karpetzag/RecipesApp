//
//  RecipesListRecipesListPresenterTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class RecipesListPresenterTest: XCTestCase {

    private var presenter: RecipesListPresenter!
    private var mockView: MockViewController!
    private var mockInteractor: MockInteractor!
    private var mockRouter: MockRouter!
    private var category = RecipesApp.Category.testCategories(count: 1).first!
    
    override func setUp() {
        super.setUp()

        presenter = RecipesListPresenter()
        mockView = MockViewController()
        mockInteractor = MockInteractor()
        mockRouter = MockRouter()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
        presenter.setup(withCategory: category)
    }
  
    func testAfterViewIsReadyStartObserveFavoriteStatusChange() {
        presenter.viewIsReady()
        XCTAssertTrue(mockInteractor.isStartObserveCalled)
    }
    
    func testAfterRecipeAddedToFavoritesViewIsUpdated() {
        presenter.didAddRecipeToFavorites(recipe: addRecipesToPresenter().first!)

        XCTAssertNotNil(mockView.updatedIndex)
        XCTAssertNotNil(mockView.updatedViewModel)
    }
    
    func testAfterRecipeRemovedFromFavoritesViewIsUpdated() {
        presenter.didRemoveRecipeFromFavorites(recipe: addRecipesToPresenter().first!)
        
        XCTAssertNotNil(mockView.updatedIndex)
        XCTAssertNotNil(mockView.updatedViewModel)
    }
    
    func testIfRecipeIsAddedToFavoritesViewModelsHaveCorrectStatus() {
        mockInteractor.isFavorite = true
        let recipes = addRecipesToPresenter()
        
        XCTAssertEqual(mockView.viewModels!.filter({ $0.isFavorite }).count, recipes.count)
    }
    
    func testWhenViewIsReadyStartLoadData() {
        presenter.viewIsReady()
        XCTAssertTrue(mockInteractor.loadRecipesIsCalled)
    }
    
    func testOnViewRefreshReloadRecipes() {
        presenter.onViewRefesh()
        XCTAssertTrue(mockInteractor.loadRecipesIsCalled)
    }
    
    func testAfterUserSelectsRecipeShowDetails() {
        let interactor = InteractorFetchResult(requestResult: .success(RecipePreview.testPreviews(count: 10)), cachedContent: nil)
        presenter.didFinishLoadAllRecipes(result: interactor)
        presenter.didSelectRecipe(atIndex: 0)
        XCTAssertTrue(mockRouter.showDetailsCalled)
    }
    
    @discardableResult
    private func addRecipesToPresenter() -> [RecipePreview] {
        let recipes = RecipePreview.testPreviews(count: 10)
        let result = InteractorFetchResult(requestResult: .success(recipes), cachedContent: nil)
        presenter.didFinishLoadAllRecipes(result: result)
        return recipes
    }
    
    class MockInteractor: RecipesListInteractorInput {
        
        var isStartObserveCalled = false
        var isFavorite = false
        var loadRecipesIsCalled = false
        
        func loadAllRecipes(category: RecipesApp.Category) {
            loadRecipesIsCalled = true
        }
        
        func isFavorite(recipe: RecipePreview) -> Bool {
            return isFavorite
        }
        
        func startObserveFavoriteStatusChange() {
            isStartObserveCalled = true
        }

    }

    class MockRouter: RecipesListRouterInput {
        var showDetailsCalled = false
        
        func showRecipeDetails(recipeId: String) {
            showDetailsCalled = true
        }
    }

    class MockViewController: BaseViewMock, RecipesListViewInput {
        var viewModels: [RecipePreviewViewModel]?
        var updatedViewModel: RecipePreviewViewModel?
        var updatedIndex: Int?
        
        func endUpdate(withRecipes recipes: [RecipePreviewViewModel]) {
            viewModels = recipes
        }
        
        func update(viewModel: RecipePreviewViewModel, atIndex index: Int) {
            updatedViewModel = viewModel
            updatedIndex = index
        }
        
        func setupInitialState() {

        }
    }
}
