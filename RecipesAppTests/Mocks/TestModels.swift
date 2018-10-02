//
//  TestModel.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 11/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
import SwiftyJSON

@testable import RecipesApp

extension RecipesApp.Category {
    
    static func testCategory() -> RecipesApp.Category {
        return testCategories(count: 1).first!
    }
    
    static func testCategories(count: Int) -> [RecipesApp.Category] {
        return (0..<count).map({ RecipesApp.Category(id: "\($0)", title: "", imageURL: nil, description: "") })
    }
    
}

extension RecipePreview {
    
    static func testPreviews(count: Int) -> [RecipePreview] {
        return (0..<count).map({ RecipePreview(id: "\($0)", title: "", imageURL: nil) })
    }
    
}

extension Recipe {
    
    static func testRecipe(title: String = "", imageURL: URL? = nil, instructions: String = "", ingredients: [RecipesIngredient] = []) -> Recipe {
        return Recipe(preview: RecipePreview(id: "123", title: title, imageURL: imageURL),
                      instructions: instructions,
                      ingredients: ingredients)
    }
}

class TestApiResultsProvider {
    
    static func testSuccessCategoriesApiResult() -> ApiResult {
        return testSuccessApiResult(filename: "TestCategories")
    }
    
    static func testSuccessPreviewsApiResult() -> ApiResult {
        return testSuccessApiResult(filename: "TestPreviews")
    }
    
    static func testSuccessRecipeApiResult() -> ApiResult {
        return testSuccessApiResult(filename: "TestRecipe")
    }
    
    private static func testSuccessApiResult(filename: String) -> ApiResult {
        let bundle = Bundle(for: self)
        let json = bundle.path(forResource: filename, ofType: "json")!
        let data = try! String(contentsOfFile: json)
        return ApiResult.success(ApiSuccessResponse(originalData: data, json: JSON(parseJSON: data)))
    }
}
