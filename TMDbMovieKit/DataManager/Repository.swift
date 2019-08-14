//
//  Repository.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct Repository {

    enum Location {
        case cache

        var path: String {
            switch self {
            case .cache:
                return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
            }
        }
    }

    enum Error: Swift.Error {
        case encoding
        case writeError
    }
    
    // MARK: Properties

    static let cache = Repository(path: Repository.Location.cache.path)

    private let path: String

    private let fileAccessQueue = DispatchQueue(label: "com.exampleproject.app.repository.serial", qos: .background)

    private let fileManager: FileManaging

    // MARK: Initialize

    init(path: String, fileManager: FileManaging = FileManager.default) {
        self.path = path
        self.fileManager = fileManager
        self.setupDirectory()
    }

    // MARK: Persistence

    func persistData<T: Codable>(data: T, withIdentifier identifier: String, completion: ((Result<Void, Error>) -> Void)? = nil) {
        fileAccessQueue.async(flags: .barrier) {
            do {
                let data = try JSONEncoder().encode(data)
                let url = self.url(identifier: identifier)
                if self.fileManager.createFile(atPath: url.path, contents: data, attributes: [:]) {
                    completion?(.success(()))
                } else {
                    completion?(.failure(.writeError))
                }
            } catch {
                completion?(.failure(.encoding))
                print("Error saving object to disk, reasons: \(error.localizedDescription)")
            }
        }
    }

    func restoreData<T: Codable>(forIdentifier identifier: String) -> T? {
        var object: T?

        fileAccessQueue.sync {
            do {
                guard let data = fileManager.contents(atPath: self.url(identifier: identifier).path) else { return }
                object = try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Error reading file from disk, reason: \(error.localizedDescription)")
            }
        }

        return object
    }

    func clearData(withIdentifier identifier: String) {
        let path = self.url(identifier: identifier).path

        fileAccessQueue.async {
            do {
                try self.fileManager.removeItem(atPath: path)
            } catch {
                print("Could not clear cached file at path: \(path))")
            }
        }
    }

    // MARK: Utils

    private func setupDirectory() {
        do {
            try self.fileManager.createDirectory(atPath: "\(path)/discovermovies", withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating a new directory")
        }
    }
    // Refactor into a method that creates a path
    private func url(identifier: String) -> URL {
        return URL(fileURLWithPath: "\(path)/discovermovies/\(identifier)")
    }
}
