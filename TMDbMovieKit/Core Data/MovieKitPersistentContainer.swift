//
//  MovieKitPersistentContainer.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 23/11/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import CoreData

public final class MovieKitPersistentContainer: NSPersistentContainer {

    // MARK: Properties

    /// The background context used for writing to the persistent store.
    public lazy var backgroundcontext = newBackgroundContext()

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
                // TODO: - Handle migration 
                //            }
            }

            print(container.persistentStoreDescriptions.first)

            // Setup the view context
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            completion(container)
        }
    }
}
