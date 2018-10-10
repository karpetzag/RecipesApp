//
//  CategoriesListCategoriesListPresenterTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class CategoriesListPresenterTest: XCTestCase {

    private var presenter: CategoriesListPresenter!
    private var mockView: MockViewController!
    private var mockInteractor: MockInteractor!
    private var mockRouter: MockRouter!

    override func setUp() {
        super.setUp()
        presenter = CategoriesListPresenter()
        mockView = MockViewController()
        mockInteractor = MockInteractor()
        mockRouter = MockRouter()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    func testOnViewRefreshShouldLoadCategories() {
        presenter.onViewRefresh()
        XCTAssertTrue(mockInteractor.loadIsCalled)
    }
    
    func testWhenViewIsReadyShouldStartLoadData() {
        presenter.viewIsReady()
        XCTAssertTrue(mockInteractor.loadIsCalled)
    }
    
    func testWhenUserSelectsCategoryShouldShowRecipesList() {
        let categories = RecipesApp.Category.testCategories(count: 10)
        let result = InteractorFetchResult(requestResult: .success(categories), cachedContent: nil)
        presenter.didLoadCategories(result: result)

        let index = 0
        presenter.didSelectCategory(atIndex: index)
        
        XCTAssertNotNil(mockRouter.category)
        XCTAssertEqual(mockRouter.category, categories[index])
    }
    
    func testWhenDataIsReloadedShouldShowViewModels() {
        let categories = RecipesApp.Category.testCategories(count: 10)
        let result = InteractorFetchResult(requestResult: .success(categories), cachedContent: nil)
        
        presenter.didLoadCategories(result: result)
        
        XCTAssertEqual(mockView.categories.count, categories.count)
    }
    
    func testWhenDataIsReloadedShouldNotShowErrorMessages() {
        let categories = RecipesApp.Category.testCategories(count: 10)
        let result = InteractorFetchResult(requestResult: .success(categories), cachedContent: nil)
        presenter.didLoadCategories(result: result)
        XCTAssertFalse(mockView.showErrorMessageIsCalled)
    }
    
    func testWhenUpdateIsFailedShouldShowErrorMessage() {
        let result = InteractorFetchResult<[RecipesApp.Category]>(requestResult: .failure(ApiInternalError.unknown), cachedContent: nil)
        presenter.didLoadCategories(result: result)
        XCTAssertTrue(mockView.showErrorMessageIsCalled)
    }
    
    class MockInteractor: CategoriesListInteractorInput {
        
        var loadIsCalled = false
        
        func loadCategories() {
            loadIsCalled = true
        }
    }

    class MockRouter: CategoriesListRouterInput {
        var category: RecipesApp.Category?
        
        func showRecipes(forCategory category: RecipesApp.Category) {
            self.category = category
        }
    }

    class MockViewController: BaseViewMock, CategoriesListViewInput {
        var categories = [CategoryViewModel]()
        
        func setupInitialState() {
            
        }
        
        func endUpdate(withCategories categories: [CategoryViewModel]) {
            self.categories = categories
        }
    }
}
