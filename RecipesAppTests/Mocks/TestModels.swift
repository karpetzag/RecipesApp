//
//  TestModel.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 11/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
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
    
    static func testRecipes(count: Int) -> [Recipe] {
        return (0..<count).map({ Recipe(preview: RecipePreview(id: "\($0)", title: "", imageURL: nil),
                                        instructions: "",
                                        ingredients: []) })
    }
}
