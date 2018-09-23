//
//  RecipeServiceTests.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 22/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import RecipesApp

class RecipeServiceTests: XCTestCase {
    
    private var apiClientMock: ApiClientMock!
    private var service: DefaultRecipesService!
    private var mapper: DefaultResponseMapper!
    
    override func setUp() {
        super.setUp()
        mapper = DefaultResponseMapper()
        apiClientMock = ApiClientMock()
        
        service = DefaultRecipesService(apiClient: apiClientMock, mapper: mapper)
        
    }
    
    private func categoriesString() -> JSON {
        let json = Bundle.main.path(forResource: "TestCategories", ofType: "json")!
        let data = try! String(contentsOfFile: json)
        let result = JSON(data)
        return result
        
    }
  
}
