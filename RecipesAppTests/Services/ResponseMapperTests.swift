//
//  ResponseMapperTests.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 23/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import RecipesApp

class ResponseMapperTests: XCTestCase {
    
    var mapper: DefaultResponseMapper!
    
    override func setUp() {
        super.setUp()
        mapper = DefaultResponseMapper()
    }
    
    func testReturnSuccesResultForValidApiResult() {
        let result = ApiResult.success(ApiSuccessResponse(originData: Data(), json: categoriesJSON()))
        
        let e = XCTestExpectation(description: "Response parsing")
        
        mapper.mapObjectsFromApiResult(result: result,
                                       toItemsWithType: RecipesApp.Category.self,
                                       dataKey: "categories") { (result) in
                                        XCTAssertTrue(result.resultItem!.count > 0)
                                        e.fulfill()
        }
        
        wait(for: [e], timeout: 0.5)
    }
  
    func testReturnFailureResultForErrorApiResult() {
        let result = ApiResult.failure(ApiInternalError.unknown)
        
        let e = XCTestExpectation(description: "Response parsing")
        
        mapper.mapObjectsFromApiResult(result: result,
                                       toItemsWithType: RecipesApp.Category.self,
                                       dataKey: "categories") { (result) in
                                        XCTAssertTrue(result.error != nil)
                                        e.fulfill()
        }
        
        wait(for: [e], timeout: 0.5)
    }
    
    func testReturnFailureResultIfNoContentByDataKey() {
        let result = ApiResult.success(ApiSuccessResponse(originData: Data(), json: categoriesJSON()))

        let e = XCTestExpectation(description: "Response parsing")
        
        let invalidKey = "invalidKey"
        
        mapper.mapObjectsFromApiResult(result: result,
                                       toItemsWithType: RecipesApp.Category.self,
                                       dataKey: invalidKey) { (result) in
                                        XCTAssertTrue(result.error != nil)
                                        e.fulfill()
        }
        
        wait(for: [e], timeout: 0.5)
    }
    
    private func categoriesJSON() -> JsonReponse {
        let bundle = Bundle(for: type(of: self))
        let json = bundle.path(forResource: "TestCategories", ofType: "json")!
        let data = try! String(contentsOfFile: json)
        let result = JSON(parseJSON: data)
        return result
    }
}
