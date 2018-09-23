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
    
    func isFileExist(name: String) -> Bool {
        return false
    }
    
    func pathForFile(withName name: String) -> URL {
        fatalError()
    }
    
    func remove(name: String) {
        isRemoveCalled = true
    }
    
    func add(content: Data, filename: String, subdirectoryName: String?) {
        isAddContentCalled = true
    }
    
    func contentsOfDirectory(name: String) -> [String] {
        return []
    }

}
