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

struct Repository {
  
    // MARK: - Properties 
    
    static let cache = Repository(path: RepositoryLocation.cache.path)
    
    private let path: String
    
    private let fileAccessQueue = DispatchQueue(label: "com.discoverMovies.app.repository.serial", qos: .background)

    // MARK: - Initialize
    
    init(path: String) {
        self.path = path
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
    
    func clearData(withIdentifier identifier: String) {
        
        let path = self.file(forIdentifier: identifier)
        
        fileAccessQueue.async {
            do {
                try FileManager().removeItem(atPath: path)
            } catch {
                print("Could not clear cached file at path: \(path))")
            }
            
        }
    }
    
    // MARK: - Location
    
    private func createDirectory() {
        do {
            try FileManager.default.createDirectory(atPath: "\(path)/data", withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating a new directory")
        }
    }
    
    private func file(forIdentifier identifier: String) -> String {
        return "\(path)/data/\(identifier).plist"
    }
}
