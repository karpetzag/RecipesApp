//
//  Category.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 10/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

final class Category: Codable {
    
    let id: String
    let title: String
    let imageURL: URL?
    let description: String
    
    init(id: String, title: String, imageURL: URL?, description: String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.description = description
    }
}

extension Category: Equatable {
    
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.imageURL == rhs.imageURL && lhs.description == rhs.description
    }
    
}

extension Category: Mappable {
    
    static func object(fromResponse response: JsonReponse) -> Category? {
        guard let id = response["idCategory"].string else {
            return nil
        }
        
        return Category(id: id,
                        title: response["strCategory"].stringValue,
                        imageURL: response["strCategoryThumb"].url,
                        description: response["strCategoryDescription"].stringValue)
    }
}
