//
//  FileCacheMock.swift
//  RecipesAppTests
//
//  Created by Andrey Karpets on 15/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
@testable import RecipesApp

class FileCacheMock: FileCache {
    
    var isAddContentCalled = false
    var isRemoveCalled = false
    var isLoadContentCalled = false
    var contentToReturn: Data?
    var isFileExist = false
    var pathToReturn: URL!
    
    func isFileExist(name: String) -> Bool {
        return isFileExist
    }
    
    func pathForFile(withName name: String) -> URL {
        return pathToReturn
    }
    
    func remove(name: String) {
        isRemoveCalled = true
    }
    
    func add(content: Data, filename: String, subdirectoryName: String?) {
        isAddContentCalled = true
    }
    
    func filenamesInDirectory(name: String) -> [String] {
        return []
    }

    func content(filename: String, subdirectoryName: String?) -> Data? {
        isLoadContentCalled = true
        return contentToReturn
    }
}
