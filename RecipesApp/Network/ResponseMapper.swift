//
//  ResponseMapper.swift
//  CoolRocket
//
//  Created by Andrey Karpets on 20/07/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

enum DataResult<T> {
    case success(T)
    case failure(Error)
    
    var resultItem: T? {
        switch self {
        case .success(let item): return item
        default: return nil
            
        }
    }
    
    var error: Error? {
        switch self {
        case .failure(let e): return e
        default: return nil
            
        }
    }
}

typealias ResultHandler<T> = (DataResult<T>) -> ()

protocol ResponseMapper {
    
    func mapObjectsFromApiResult<T: Mappable>(result: ApiResult, toItemsWithType type: T.Type, dataKey: String, completion: @escaping ResultHandler<[T]>)
}

class DefaultResponseMapper: ResponseMapper {
        
    func mapObjectsFromApiResult<T>(result: ApiResult,
                                    toItemsWithType type: T.Type,
                                    dataKey: String,
                                    completion: @escaping (DataResult<[T]>) -> ()) where T : Mappable {
        switch result {
        case .success(let response):
            guard let items = response.json[dataKey].array else {
                completion(.failure(ApiInternalError.invalidResponseFormat))
                return
            }
            DispatchQueue.global().async {
                let mappedItems = T.objects(fromResponse: items)
                DispatchQueue.main.async {
                    completion(.success(mappedItems))
                }
            }
        case .failure(let response):
            completion(.failure(response))
        }
    }
}
