//
//  ResponseMapperMock.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 24/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp

class MockResponseMapper: ResponseMapper {
    
    var result: ApiResult?
    var type: Any.Type?
    var dataKey: String?
    
    func mapObjectsFromApiResult<T>(result: ApiResult,
                                    toItemsWithType type: T.Type,
                                    dataKey: String,
                                    completion: @escaping (DataResult<[T]>) -> ()) where T : Mappable {
        self.dataKey = dataKey
        self.type = type
        self.dataKey = dataKey
    }

}
