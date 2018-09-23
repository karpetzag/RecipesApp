//
//  FavoriteRecipesServiceMock.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 23/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp

class MockFavoriteRecipesService: FavoriteRecipesService {
    var isAddedToFavoritesCalled = false
    var isAddedToFavorites = false
    var addedObserver: FavoriteStatusObserver?
    
    func add(recipe: Recipe) {
        
    }
    
    func remove(recipe: Recipe) {
        
    }
    
    func isAddedToFavorite(recipeId: String) -> Bool {
        isAddedToFavoritesCalled = true
        return isAddedToFavorites
    }
    
    func add(observer: FavoriteStatusObserver) {
        addedObserver = observer
    }
    
}
