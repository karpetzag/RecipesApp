//
//  Recipe.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 09/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

final class RecipesIngredient: Codable {
    let title: String
    let measureValue: String
    
    init(title: String, measureValue: String) {
        self.title = title
        self.measureValue = measureValue
    }
}

extension RecipesIngredient: Equatable {
    
    static func ==(lhs: RecipesIngredient, rhs: RecipesIngredient) -> Bool {
        return lhs.title == rhs.title && lhs.measureValue == rhs.measureValue
    }
}

final class Recipe: Codable {
    
    let preview: RecipePreview
    let instructions: String
    let ingredients: [RecipesIngredient]
    
    var id: String {
        return preview.id
    }
    
    init(preview: RecipePreview, instructions: String, ingredients: [RecipesIngredient]) {
        self.preview = preview
        self.ingredients = ingredients
        self.instructions = instructions
    }
}

extension Recipe: Equatable {
    
    static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.preview == rhs.preview && lhs.instructions == rhs.instructions && lhs.ingredients == rhs.ingredients
    }

}

extension Recipe: Mappable {
    
    static func object(fromResponse response: JsonReponse) -> Recipe? {
        guard let preview = RecipePreview.object(fromResponse: response) else {
            return nil
        }
    
        var index = 1

        var recipesIngredients = [RecipesIngredient]()
        while true {
            guard let title = response["strIngredient\(index)"].string, !title.isEmpty,
                let measure = response["strMeasure\(index)"].string else {
                break
            }
            
            let ingredient = RecipesIngredient(title: title, measureValue: measure)
            recipesIngredients.append(ingredient)
            index += 1
        }
        
        return Recipe(preview: preview, instructions: response["strInstructions"].stringValue, ingredients: recipesIngredients)
    }
}
