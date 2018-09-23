//
//  Cache.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 09/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

protocol CategoryLocalStorage {
    
    func update(withCategories categories: [Category])
    
    func load() -> [Category]?
}

protocol RecipesLocalStorage {
    
    func update(recipes: [RecipePreview], categoryId: String)
    
    func load(categoryId: String) -> [RecipePreview]?
    
    func update(recipe: Recipe)

    func load(recipeId: String) -> Recipe?
}

class DefaultCategoryLocalStorage: CategoryLocalStorage {
    
    private let fileCache: FileCache

    private static let filename = "categories"
    
    init(fileCache: FileCache) {
        self.fileCache = fileCache
    }
    
    func update(withCategories categories: [Category]) {
        guard let json = try? JSONEncoder().encode(categories) else {
            return
        }
        fileCache.add(content: json, filename: DefaultCategoryLocalStorage.filename, subdirectoryName: nil)
    }
    
    func load() -> [Category]? {
        let url = fileCache.pathForFile(withName: DefaultCategoryLocalStorage.filename)
        guard let json = try? Data(contentsOf: url) else {
            return nil
        }
        
        return try? JSONDecoder().decode([Category].self, from: json)
    }
}

class DefaultRecipesLocalStorage: RecipesLocalStorage {
   
    private let fileCache: FileCache
    
    private static let recepiesFilename = "recepies"
    private static let singleRecepieFilename = "recepie"
    
    init(fileCache: FileCache) {
        self.fileCache = fileCache
    }
    
    func update(recipes: [RecipePreview], categoryId: String) {
        guard let json = try? JSONEncoder().encode(recipes) else {
            return
        }

        fileCache.add(content: json, filename: DefaultRecipesLocalStorage.recepiesFilename + categoryId, subdirectoryName: nil)
    }
    
    func load(categoryId: String) -> [RecipePreview]? {
        let url = fileCache.pathForFile(withName: DefaultRecipesLocalStorage.recepiesFilename + categoryId)
        guard let json = try? Data(contentsOf: url) else {
            return nil
        }
        
        return try? JSONDecoder().decode([RecipePreview].self, from: json)
    }
    
    func update(recipe: Recipe) {
        guard let json = try? JSONEncoder().encode(recipe) else {
            return
        }
    
        fileCache.add(content: json,
                      filename: DefaultRecipesLocalStorage.singleRecepieFilename + recipe.id,
                      subdirectoryName: nil)
    }
    
    func load(recipeId: String) -> Recipe? {
        let url = fileCache.pathForFile(withName: DefaultRecipesLocalStorage.singleRecepieFilename + recipeId)
        guard let json = try? Data(contentsOf: url) else {
            return nil
        }
        
        return try? JSONDecoder().decode(Recipe.self, from: json)
    }
}
