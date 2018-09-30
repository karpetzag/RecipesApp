//
//  RecipesListRecipesListRouterTests.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 05/09/2018.
//  Copyright © 2018 AK. All rights reserved.
//

import XCTest
@testable import RecipesApp

class RecipesListRouterTests: XCTestCase {

    private var router: RecipesListRouter!
    private var mockNavigator: MockNavigator<RecipeDetailsModuleInput>!
    
    override func setUp() {
        super.setUp()
        
        mockNavigator = MockNavigator<RecipeDetailsModuleInput>()
        router = RecipesListRouter()
        router.navigator = mockNavigator
    }

    func testWhenShowRecipeDetailsShouldSetupModule() {
        let recipeId = "123"
        router.showRecipeDetails(recipeId: recipeId)
        let mockInput = MockRecipeDetailsModuleInput()
        mockNavigator.setupHandler?(mockInput)
        
        XCTAssertEqual(recipeId, mockInput.recipeId)
    }
    
    class MockRecipeDetailsModuleInput: RecipeDetailsModuleInput {
        
        var recipeId: String?
        
        func setup(recipeId: String) {
            self.recipeId = recipeId
        }
    }
}
