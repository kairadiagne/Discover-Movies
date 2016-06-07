//
//  TMDbCache.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06-06-16.
//
//

import Foundation

class TMDbCache<T: NSCoding> {
    
    // MARK: Properties
    
    private let queue = dispatch_queue_create("com.discoverMovies.app.cache", DISPATCH_QUEUE_SERIAL)
    
    // MARK: Write to Disk
    
    func cacheData(data: T, directory: Directory) {
        dispatch_async(queue) {
            let data = NSKeyedArchiver.archivedDataWithRootObject(data)
            do {
                // Atomic writes guarantee that the dat is either saved in its entirety, or it fails completely.
                try data.writeToFile(directory.filePath.path!, options: .AtomicWrite )
            }
            catch let error {
                print("Save to disk operation failed: \(error)")
            }
        }
    }

    // MARK: Retrieve from Disk
    
    func loadDataFromCache(directory: Directory, completionHandler: (data: T?) -> Void) {
        var cachedData: T?
        dispatch_async(queue) {
            if let data = NSKeyedUnarchiver.unarchiveObjectWithFile(directory.filePath.path!) as? T {
                cachedData = data
            }
        }
        completionHandler(data: cachedData)
    }
    
}
