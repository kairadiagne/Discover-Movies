//
//  Repository.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

/// A `Repository` class that manages the storage of `Codable` data in a speicifc folder on the file system.
final class Repository {

    enum Error: Swift.Error {

        /// An error has occured with decoding the object from data.
        case decoding

        /// An error has occured with encoding an object into data.
        case encoding

        /// An error has occured with writing the data to the specificied directory in the filesystem.
        case writeError
    }
    
    // MARK: - Properties

    /// A shared `Repository` that writes its data to the users caches directory.
    static let cache = Repository(path: Location.cache.path)

    /// The path of the directory in which the data is stored.
    private let path: String

    /// A background dispatch queue on which all interactions with the file system are executed. It supports concurrent reads, writes are always done serially.
    private let fileAccessQueue = DispatchQueue(label: "com.tmdbmoviekit.repository.serial", qos: .background, attributes: .concurrent)

    /// The object responsible for handling all the interaction with the iOS filesystem.
    private let fileManager: FileManaging

    /// The encoder to use for encoding the model objects into data.
    private lazy var jsonEncoder = JSONEncoder()

    /// The decoder to use for decoding json back into model objects.
    private lazy var jsonDecoder = JSONDecoder()

    // MARK: - Initialize

    init(path: String, fileManager: FileManaging = FileManager.default) {
        self.path = path
        self.fileManager = fileManager
        self.setupDirectory()
    }

    // MARK: - Persistence

    func persistData<T: Codable>(data: T, withIdentifier identifier: String, completion: ((Result<Void, Error>) -> Void)?) {
        fileAccessQueue.async(flags: .barrier) {
            do {
                let data = try self.jsonEncoder.encode(data)
                let url = self.url(identifier: identifier)
                if self.fileManager.createFile(atPath: url.path, contents: data, attributes: [:]) {
                    completion?(.success(()))
                } else {
                    completion?(.failure(.writeError))
                }
            } catch {
                print("Error saving object to disk, reasons: \(error.localizedDescription)")
                completion?(.failure(.encoding))
            }
        }
    }

    func restoreData<T: Codable>(forIdentifier identifier: String) -> T? {
        var object: T?

        fileAccessQueue.sync {
            do {
                guard let data = fileManager.contents(atPath: self.url(identifier: identifier).path) else { return }
                object = try self.jsonDecoder.decode(T.self, from: data)
            } catch {
                print("Error reading file from disk, reason: \(error.localizedDescription)")
            }
        }

        return object
    }

    func clearData(withIdentifier identifier: String) {
        let path = self.url(identifier: identifier).path

        fileAccessQueue.async(flags: .barrier) {
            do {
                try self.fileManager.removeItem(atPath: path)
            } catch {
                print("Could not clear cached file at path: \(path))")
            }
        }
    }

    // MARK: - Utils

    private func setupDirectory() {
        do {
            try self.fileManager.createDirectory(atPath: "\(path)/discovermovies", withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating a new directory")
        }
    }

    private func url(identifier: String) -> URL {
        return URL(fileURLWithPath: "\(path)/discovermovies/\(identifier)")
    }
}

enum Location {
    case cache

    var path: String {
        switch self {
        case .cache:
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        }
    }
}
