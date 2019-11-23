//
//  CastMember+CoreDataProperties.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

extension CastMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CastMember> {
        return NSFetchRequest<CastMember>(entityName: "CastMember")
    }

    @NSManaged public var castIdentifier: String?
    @NSManaged public var character: String?
    @NSManaged public var identifier: Int64
    @NSManaged public var name: String?
    @NSManaged public var order: Int64
    @NSManaged public var profilePath: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension CastMember {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
