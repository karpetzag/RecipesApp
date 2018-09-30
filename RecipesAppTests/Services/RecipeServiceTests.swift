//
//  RecipeServiceTests.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 22/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import RecipesApp

class RecipeServiceTests: XCTestCase {
    
    private var mapperMock: MockResponseMapper!
    private var apiClientMock: ApiClientMock!
    
    private var service: DefaultRecipesService!
    
    override func setUp() {
        super.setUp()
        mapperMock = MockResponseMapper()
        apiClientMock = ApiClientMock()
        
        service = DefaultRecipesService(apiClient: apiClientMock, mapper: mapperMock)
    }
    
    func testWhenGetCategoriesResponseShouldUseMapperToParseData() {
        apiClientMock.result = TestApiResultsProvider.testSuccessCategoriesApiResult()
        
        service.loadCategories { (result) in  }
        XCTAssertEqual(self.mapperMock.dataKey, "categories")
        XCTAssertTrue( self.mapperMock.type! == RecipesApp.Category.self)
    }
    
    func testWhenGetPreviewsResponseShouldUseMapperToParseData() {
        apiClientMock.result = TestApiResultsProvider.testSuccessPreviewsApiResult()
        
        service.loadRecipePreviews(forCategory: RecipesApp.Category.testCategory(), completion: { _ in})
        XCTAssertEqual(self.mapperMock.dataKey, "meals")
        XCTAssertTrue( self.mapperMock.type! == RecipePreview.self)
    }
    
    func testWhenGetRecipeResponseShouldUseMapperToParseData() {
        apiClientMock.result = TestApiResultsProvider.testSuccessRecipeApiResult()

        service.loadRecipe(withId: "") { _ in }
        XCTAssertEqual(self.mapperMock.dataKey, "meals")
        XCTAssertTrue( self.mapperMock.type! == Recipe.self)
    }
    
    func testWhenLoadCategoriesShouldUseApiClient() {
        service.loadCategories { _ in  }
        XCTAssertEqual(apiClientMock.sentRequest?.methodName, "categories.php")
    }
    
    func testWhenLoadPreviewsShouldUseApiClient() {
        service.loadRecipePreviews(forCategory: RecipesApp.Category.testCategory(), completion: { _ in})
        XCTAssertEqual(apiClientMock.sentRequest?.methodName, "filter.php")
    }
    
    func testWhenLoadRecipeShouldUseApiClient() {
        service.loadRecipe(withId: "", completion: { _ in })
        XCTAssertEqual(apiClientMock.sentRequest?.methodName, "lookup.php")
    }
}
