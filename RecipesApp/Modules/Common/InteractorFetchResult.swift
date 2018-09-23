//
//  InteractorFetchResult.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 23/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

struct InteractorFetchResult<T> {
    let requestResult: DataResult<T>
    let cachedContent: T?
    
    var resultItem: T? {
        switch requestResult {
        case .success(let data):
            return data
        case .failure:
            return cachedContent ?? nil
        }
    }
}
