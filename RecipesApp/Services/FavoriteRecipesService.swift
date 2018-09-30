//
//  FavoriteRecipesService.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

protocol FavoriteStatusObserver: class {
    
    func didRemoveFromFavorites(recipe: Recipe)
    
    func didAddToFavorites(recipe: Recipe)
}

protocol FavoriteRecipesService {
     
    func add(recipe: Recipe)
    
    func remove(recipe: Recipe)
    
    func isAddedToFavorite(recipeId: String) -> Bool
    
    func add(observer: FavoriteStatusObserver)
}

class DefaultFavoriteRecipesService: FavoriteRecipesService {
  
    private class Observer {
        
        weak var favoriteStatusObserver: FavoriteStatusObserver?
        
        init(favoriteStatusObserver: FavoriteStatusObserver?) {
            self.favoriteStatusObserver = favoriteStatusObserver
        }
    }
      
    private let fileCache: FileCache
    
    private static let dirName = "favorites"
    
    private var observers = [Observer]()
    
    init(fileCache: FileCache) {
        self.fileCache = fileCache
    }
    
    func add(observer: FavoriteStatusObserver) {
        observers.append(Observer(favoriteStatusObserver: observer))
    }
    
    func add(recipe: Recipe) {
        guard let json = try? JSONEncoder().encode(recipe) else {
            return
        }
    
        fileCache.add(content: json, filename: "\(recipe.id)", subdirectoryName: DefaultFavoriteRecipesService.dirName)
        removeEmptyObservers()
        observers.forEach({ $0.favoriteStatusObserver?.didAddToFavorites(recipe: recipe) })
    }
    
    func remove(recipe: Recipe) {
        fileCache.remove(name: filepath(forRecipeId: recipe.id))
        removeEmptyObservers()
        observers.forEach({ $0.favoriteStatusObserver?.didRemoveFromFavorites(recipe: recipe) })
    }
    
    func isAddedToFavorite(recipeId: String) -> Bool {
        return fileCache.isFileExist(name: filepath(forRecipeId: recipeId)) 
    }
    
    private func removeEmptyObservers() {
        observers = observers.filter({ $0.favoriteStatusObserver != nil })
    }
    
    private func filepath(forRecipeId recipeId: String) -> String {
        let dirName = DefaultFavoriteRecipesService.dirName
        return dirName + "/\(recipeId)"
    }
}
