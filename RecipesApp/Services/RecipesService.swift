//
//  RecipesService.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 09/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

protocol RecipesService {
    
    func loadCategories(withCompletion completion: @escaping (Result<[Category]>)->())
    
    func loadRecipePreviews(forCategory category: Category, completion: @escaping (Result<[RecipePreview]>)->())
    
    func loadRecipe(withId id: String, completion: @escaping (Result<Recipe>)->())
}

class DefaultRecipesService: RecipesService {
     
    private let apiClient: ApiClient
    private let mapper: ResponseMapper
    
    init(apiClient: ApiClient, mapper: ResponseMapper) {
        self.apiClient = apiClient
        self.mapper = mapper
    }
    
    func loadCategories(withCompletion completion: @escaping (Result<[Category]>) -> ()) {
        let request = ApiRequest(httpMethod: .get, methodName: "categories.php")
        apiClient.send(request: request) { [weak self] (result) in
            self?.mapper.mapObjectsFromApiResult(result: result,
                                                 toItemsWithType: Category.self,
                                                 dataKey: "categories", completion: completion)
        }
    }
    
    func loadRecipePreviews(forCategory category: Category, completion: @escaping (Result<[RecipePreview]>)->()) {
        let params = ["c": category.title]
        let request = ApiRequest(httpMethod: .get, methodName: "filter.php", params: params)
        apiClient.send(request: request) { [weak self] (result) in
            self?.mapper.mapObjectsFromApiResult(result: result, toItemsWithType: RecipePreview.self, dataKey: "meals", completion: completion)
        }
    }
    
    func loadRecipe(withId id: String, completion: @escaping (Result<Recipe>) -> ()) {
        let params = ["i": id]
        let request = ApiRequest(httpMethod: .get, methodName: "lookup.php", params: params)
        apiClient.send(request: request) { [weak self] (result) in
            self?.mapper.mapObjectsFromApiResult(result: result, toItemsWithType: Recipe.self, dataKey: "meals", completion: { mappedResult in
                //For some reason api returns array with single element instead of object
                switch mappedResult {
                case .success(let items):
                    if let item = items.first {
                        completion(.success(item))
                    } else {
                        completion(.failure(ApiInternalError.unknown))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
}
