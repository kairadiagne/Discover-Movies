//
//  CrewMember+CoreDataProperties.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

extension CrewMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrewMember> {
        return NSFetchRequest<CrewMember>(entityName: "CrewMember")
    }

    @NSManaged public var creditIdentifier: String?
    @NSManaged public var department: String?
    @NSManaged public var identifier: Int64
    @NSManaged public var job: String?
    @NSManaged public var name: String?
    @NSManaged public var profilePath: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension CrewMember {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
