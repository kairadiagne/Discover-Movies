//
//  MovieKitPersistentContainer.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 23/11/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import CoreData

final class MovieKitPersistentContainer: NSPersistentContainer {

    // MARK: Properties

    lazy var backgroundcontext: NSManagedObjectContext = {
        let backgroundContext = newBackgroundContext()
        backgroundContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return backgroundContext
    }()

    // MARK: Initialize

    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)

        viewContext.automaticallyMergesChangesFromParent = true
    }

    /// Creates an instance of `PersistentContainer` and loads the underlying Persistent store of type SQLite.
    ///
    /// - Parameter completion: The completion handler that gets called when the persistent store has loaded.
    public static func createDefaultContainer(completion: @escaping (MovieKitPersistentContainer) -> Void) {
        let container = MovieKitPersistentContainer(name: "MovieKit")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                // In a production app we need to handle this error gracefully.
                // The best way to handle errors that occur at this stage depenends on the specifics of the app.
                assertionFailure("Unresovled errror loading store with description: \(description), reason: \(error.localizedDescription)")
                // completion(error)
            }
            completion(container)
        }
    }
}
