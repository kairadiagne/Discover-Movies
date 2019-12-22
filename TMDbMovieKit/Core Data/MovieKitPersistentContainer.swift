//
//  MovieKitPersistentContainer.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 23/11/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import CoreData

public final class MovieKitPersistentContainer: NSPersistentContainer {

    private static let name = "MovieKit"

    // MARK: Properties

    /// The background context used for writing to the persistent store.
    public lazy var backgroundcontext = newBackgroundContext()

    /// Creates an instance of `NSPersistentContainer` and loads the underlying Persistent store of type SQLite.
    /// - Parameter completion: The completion handler that gets called when the persistent store finished loading.
    public static func createDefaultContainer(completion: @escaping () -> Void) {
        let container = MovieKitPersistentContainer(name: MovieKitPersistentContainer.name)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                // TODO: - Handle migration error
                assertionFailure("Unresovled errror loading store with description: \(description), reason: \(error.localizedDescription)")
            }

            print(container.persistentStoreDescriptions.first!)
            container.setupContainer()
            DiscoverMoviesKit.shared.register(persistentContainer: container)
            completion()
        }
    }

    /// Creates an instance of `NSPersistentContainer` that is backed by a in memory store.
    /// - Parameter completion: The completion handler that gets called when the persistent store finished loading.
    public static func createInMemoryContainer(completion: @escaping (Result<MovieKitPersistentContainer, Error>) -> Void) {
        let container = MovieKitPersistentContainer(name: MovieKitPersistentContainer.name)
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Unresovled errror loading store with description: \(description), reason: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            container.setupContainer()
            completion(.success(container))
        }
    }

    private func setupContainer() {
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        viewContext.undoManager = nil
        viewContext.shouldDeleteInaccessibleFaults = true

        backgroundcontext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundcontext.undoManager = nil
        backgroundcontext.shouldDeleteInaccessibleFaults = true
    }
}
