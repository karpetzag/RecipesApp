//
//  CategoriesListCategoriesListRouterTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class CategoriesListRouterTests: XCTestCase {

    private var router: CategoriesListRouter!
    private var mockNavigator: MockNavigator<RecipesListModuleInput>!
    
    override func setUp() {
        super.setUp()
        
        mockNavigator = MockNavigator()
        router = CategoriesListRouter()
        router.navigator = mockNavigator
    }

    func testWhenShowsRecipesListRouterSetupModule() {
        let category = RecipesApp.Category.testCategories(count: 1).first!
        router.showRecipes(forCategory: category)
        let mockInput = MockRecipesListModuleInput()
        mockNavigator.setupHandler?(mockInput)
        
        XCTAssertNotNil(mockInput.category)
    }
    
    class MockRecipesListModuleInput: RecipesListModuleInput {
        
        var category: RecipesApp.Category?
        
        func setup(withCategory category: RecipesApp.Category) {
            self.category = category
        }
    }
}
