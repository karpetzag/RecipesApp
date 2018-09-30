//
//  FileCache.swift
//  RecipesApp
//
//  Created by Andrey Karpets on 13/09/2018.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation

protocol FileCache {
    
    func isFileExist(name: String) -> Bool
    
    func pathForFile(withName name: String) -> URL
    
    func remove(name: String)
    
    func add(content: Data, filename: String, subdirectoryName: String?)
    
    func content(filename: String, subdirectoryName: String?) -> Data?
    
    func filenamesInDirectory(name: String) -> [String]
}

class DefaultFileCache: FileCache {
        
    func isFileExist(name: String) -> Bool {
        let path = pathForFile(withName: name)
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    func pathForFile(withName name: String) -> URL {
        let cacheURL = rootDir()
        let result = cacheURL.appendingPathComponent(name)
        
        return result
    }
 
    func remove(name: String) {
        let url = pathForFile(withName: name)
        try? FileManager.default.removeItem(at: url)
    }
    
    func add(content: Data, filename: String, subdirectoryName: String?) {
        if let subdirectoryName = subdirectoryName {
            addSubDirIfNeeded(name: subdirectoryName)
        }
        
        let url = pathForFile(withName: fullPath(forFilename: filename, subdirectoryName: subdirectoryName))
        try? content.write(to: url)
    }
    
    func filenamesInDirectory(name: String) -> [String] {
        let url = pathForFile(withName: name)
        return (try? FileManager.default.contentsOfDirectory(atPath: url.path)) ?? []
    }
    
    func content(filename: String, subdirectoryName: String?) -> Data? {
        let url = pathForFile(withName: fullPath(forFilename: filename, subdirectoryName: subdirectoryName))
        return try? Data(contentsOf: url)
    }
    
    private func fullPath(forFilename filename: String, subdirectoryName: String?) -> String {
        var fullpath: String
        if let subdirectoryName = subdirectoryName {
            fullpath = subdirectoryName + "/" + filename
        } else {
            fullpath = filename
        }
        
        return fullpath
    }
    
    private func addSubDirIfNeeded(name: String) {
        let url = rootDir().appendingPathComponent(name)
        var isDirectory = ObjCBool(false)
        let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        guard !exists && !isDirectory.boolValue else {
            return
        }
        
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
    }
    
    private func rootDir() -> URL {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first ?? FileManager.default.temporaryDirectory
        return cacheURL
    }
}
