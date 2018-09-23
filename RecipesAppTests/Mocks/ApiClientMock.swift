//
//  ApiClientMock.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 22/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp

class ApiClientMock: ApiClient {
    
    var result: ApiResult?
    
    var sentRequest: ApiRequest?
    
    func send(request: ApiRequest, withCompletionHandler handler: @escaping RequestCompletionHandler) {
        sentRequest = request
        
        guard let result = result else {
            return
        }
        handler(result)
    }
    
}
