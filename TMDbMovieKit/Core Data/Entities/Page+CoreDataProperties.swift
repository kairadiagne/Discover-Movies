//
//  Page+CoreDataProperties.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

extension Page {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Page> {
        return NSFetchRequest<Page>(entityName: "Page")
    }

    @NSManaged public var number: Int64
    @NSManaged public var list: List?
    @NSManaged public var movies: NSOrderedSet?

}

// MARK: Generated accessors for movies
extension Page {

    @objc(insertObject:inMoviesAtIndex:)
    @NSManaged public func insertIntoMovies(_ value: Movie, at idx: Int)

    @objc(removeObjectFromMoviesAtIndex:)
    @NSManaged public func removeFromMovies(at idx: Int)

    @objc(insertMovies:atIndexes:)
    @NSManaged public func insertIntoMovies(_ values: [Movie], at indexes: NSIndexSet)

    @objc(removeMoviesAtIndexes:)
    @NSManaged public func removeFromMovies(at indexes: NSIndexSet)

    @objc(replaceObjectInMoviesAtIndex:withObject:)
    @NSManaged public func replaceMovies(at idx: Int, with value: Movie)

    @objc(replaceMoviesAtIndexes:withMovies:)
    @NSManaged public func replaceMovies(at indexes: NSIndexSet, with values: [Movie])

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSOrderedSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSOrderedSet)

}
