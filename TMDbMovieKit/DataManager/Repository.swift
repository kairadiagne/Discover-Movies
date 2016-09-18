//
//  Repository.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

enum RepositoryLocation {
    case cache
    
    var path: String {
        switch self {
        case .cache:
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        }
    }
}

class Repository: NSObject {
  
    // MARK: - Properties 
    
    static let cache = Repository(path: RepositoryLocation.cache.path)
    
    fileprivate let path: String
    
    fileprivate let fileAccessQueue = DispatchQueue(label: "com.discoverMovies.app.cache")
    
    // MARK: - Initialize
    
    init(path: String) {
        self.path = path
        super.init()
    }
    
    // MARK: - Persistence
    
    func persistData(data: NSCoding, withIdentifier identifier: String) {
        createDirectory()
        
        fileAccessQueue.async {
            NSKeyedArchiver.archiveRootObject(data, toFile: self.file(forIdentifier: identifier))
        }
    }
    
    func restoreData(forIdentifier identifier: String) -> Any? {
        var data: Any?
        
        fileAccessQueue.sync {
            data = NSKeyedUnarchiver.unarchiveObject(withFile: self.file(forIdentifier: identifier))
        }
        
        return data
    }
    
    // MARK: - Location
    
    fileprivate func createDirectory() {
        do {
            try FileManager.default.createDirectory(atPath: "\(path)/data", withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating a new directory")
        }
    }
    
    fileprivate func file(forIdentifier identifier: String) -> String {
        print("\(path)/data/\(identifier).plist")
        return "\(path)/data/\(identifier).plist"
    }
    
}



