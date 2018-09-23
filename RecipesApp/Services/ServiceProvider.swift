//
//  ServiceProvider.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 22/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
import Swinject

class ServiceProvider {
    static var container: Container = {
        let container = Container()
        
        container.register(FileCache.self, factory: { (r) -> FileCache in
            return DefaultFileCache()
        }).inObjectScope(ObjectScope.container)
        
        container.register(ApiClient.self, factory: { (r) -> ApiClient in
            let client = DefaultApiClient()
            client.set(baseURL: "https://www.themealdb.com/api/json/v1/1/")
            return client
        }).inObjectScope(.container)
        
        container.register(ResponseMapper.self, factory: { (r) -> ResponseMapper in
            return DefaultResponseMapper()
        }).inObjectScope(.container)
        
        container.register(RecipesService.self, factory: { (r) -> RecipesService in
            return DefaultRecipesService(apiClient: r.resolve(ApiClient.self)!, mapper: r.resolve(ResponseMapper.self)!)
        }).inObjectScope(.container)
        
        container.register(FavoriteRecipesService.self, factory: { (r) -> FavoriteRecipesService in
            return DefaultFavoriteRecipesService(fileCache: r.resolve(FileCache.self)!)
        }).inObjectScope(.container)
        
        container.register(CategoryLocalStorage.self, factory: { (r) -> CategoryLocalStorage in
            return DefaultCategoryLocalStorage(fileCache: r.resolve(FileCache.self)!)
        }).inObjectScope(.container)
        
        container.register(RecipesLocalStorage.self, factory: { (r) -> RecipesLocalStorage in
            return DefaultRecipesLocalStorage(fileCache: r.resolve(FileCache.self)!)
        }).inObjectScope(.container)
        
        return container
    }()
}
