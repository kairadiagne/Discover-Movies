//
//  Repository.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct Repository {

    enum RepositoryLocation {
        case cache

        var path: String {
            switch self {
            case .cache:
                return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
            }
        }
    }
  
    // MARK: - Properties 
    
    static let cache = Repository(path: RepositoryLocation.cache.path)
    
    private let path: String

    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()
    
    private let fileAccessQueue = DispatchQueue(label: "com.discoverMovies.app.repository.serial", qos: .background)

    // MARK: - Initialize
    
    init(path: String) {
        self.path = path
        self.setupJSONDecoder()
        self.setupJSONEncoder()
        self.setupDirectory()
    }
    
    // MARK: - Persistence
    
    func persistData<T: Codable>(object: T, cacheKey: String) {
        fileAccessQueue.async(flags: .barrier) {
            do {
                let data = try self.encoder.encode(object)
                try data.write(to: self.url(cacheKey: cacheKey), options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Error saving object to disk, reasons: \(error.localizedDescription)")
            }
        }
    }
    
    func restoreData<T: Codable>(cacheKey: String) -> T? {
        var object: T?
        
        fileAccessQueue.sync {
            do {
                let data = try Data(contentsOf: self.url(cacheKey: cacheKey))
                object = try decoder.decode(T.self, from: data)
            } catch {
                print("Error reading file from disk, reason: \(error.localizedDescription)")
            }
        }
        
        return object
    }
    
    func clearData(cacheKey: String) {
        
        let path = url(cacheKey: cacheKey).path
        
        fileAccessQueue.async {
            do {
                try FileManager().removeItem(atPath: path)
            } catch {
                print("Could not clear cached file at path: \(path))")
            }
        }
    }
    
    // MARK: - Utils

    private func setupJSONEncoder() {
    }

    private func setupJSONDecoder() {
    }

    private func setupDirectory() {
        do {
            try FileManager.default.createDirectory(atPath: "\(path)/data", withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating a new directory")
        }
    }
    
    private func url(cacheKey: String) -> URL {
        return URL(fileURLWithPath: "\(path)/data/\(cacheKey)")
    }
}
