//
//  RecipePreview.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

final class RecipePreview: Codable {
    
    let id: String
    let title: String
    let imageURL: URL?
    
    init(id: String, title: String, imageURL: URL?) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}

extension RecipePreview: Mappable {

    static func object(fromResponse response: JsonReponse) -> RecipePreview? {
        guard let id = response["idMeal"].string else {
            return nil
        }
        
        return RecipePreview(id: id, title: response["strMeal"].stringValue, imageURL: response["strMealThumb"].url)
    }
}

extension RecipePreview: Equatable {
    
    static func ==(lhs: RecipePreview, rhs: RecipePreview) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.imageURL == rhs.imageURL
    }
    
}
