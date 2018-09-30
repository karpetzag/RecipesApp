//
//  CategoryLocalStorageTests.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 29/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import XCTest
@testable import RecipesApp

class CategoryLocalStorageTests: XCTestCase {
    
    var storage: DefaultCategoryLocalStorage!
    var fileCacheMock: FileCacheMock!
    
    override func setUp() {
        super.setUp()
        
        fileCacheMock = FileCacheMock()
        storage = DefaultCategoryLocalStorage(fileCache: fileCacheMock)
    }
    
    func testWhenSaveCategoriesShouldUseFileCache() {
        storage.update(withCategories: RecipesApp.Category.testCategories(count: 10))
        XCTAssertTrue(fileCacheMock.isAddContentCalled)
    }
    
    func testWhenLoadCategoriesShouldUseFileCache() {
        _ = storage.load()
        XCTAssertTrue(fileCacheMock.isLoadContentCalled)
    }
}
