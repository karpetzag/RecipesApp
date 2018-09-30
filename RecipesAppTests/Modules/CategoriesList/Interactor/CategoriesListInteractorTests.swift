//
//  CategoriesListCategoriesListInteractorTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class CategoriesListInteractorTests: XCTestCase {

    private var interactor: CategoriesListInteractor!
    
    private let recipesServiceMock = RecipesServiceMock()
    private let storageMock = CategoryLocalStorageMock()
    private let output = MockPresenter()
    
    override func setUp() {
        super.setUp()
        
        interactor = CategoriesListInteractor(recipesService: recipesServiceMock, cache: storageMock)
        interactor.output = output
    }
    
    func testWhenGetErrorShouldUseLocalStorage() {
        recipesServiceMock.categoriesResult = .failure(ApiInternalError.unknown)
        let categories = RecipesApp.Category.testCategories(count: 10)
        storageMock.categoriesToReturn = categories
        
        interactor.loadCategories()
        
        let cachedResults = output.result.cachedContent
        
        XCTAssertTrue(cachedResults == categories)
    }

    func testWhenGetSuccessResponseShouldUseDataFromService() {
        let categories = RecipesApp.Category.testCategories(count: 10)
        recipesServiceMock.categoriesResult = .success(categories)
        interactor.loadCategories()
        
        XCTAssertEqual(output.result.requestResult.resultItem, categories)
    }
    
    func testWhenGetSuccessResponseShouldUpdateDataInCache() {
        let categories = RecipesApp.Category.testCategories(count: 10)
        recipesServiceMock.categoriesResult = .success(categories)
        interactor.loadCategories()
        
        XCTAssertEqual(storageMock.updatedCategories, categories)
    }
    
    class MockPresenter: CategoriesListInteractorOutput {

        var result: InteractorFetchResult<[RecipesApp.Category]>!
        
        func didLoadCategories(result: InteractorFetchResult<[RecipesApp.Category]>) {
            self.result = result
        }
        
    }
}
