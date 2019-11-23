//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var genres: NSObject?
    @NSManaged public var identifier: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var cast: NSOrderedSet?
    @NSManaged public var crew: NSOrderedSet?
    @NSManaged public var pages: NSSet?
    @NSManaged public var trailers: NSSet?

}

// MARK: Generated accessors for cast
extension Movie {

    @objc(insertObject:inCastAtIndex:)
    @NSManaged public func insertIntoCast(_ value: CastMember, at idx: Int)

    @objc(removeObjectFromCastAtIndex:)
    @NSManaged public func removeFromCast(at idx: Int)

    @objc(insertCast:atIndexes:)
    @NSManaged public func insertIntoCast(_ values: [CastMember], at indexes: NSIndexSet)

    @objc(removeCastAtIndexes:)
    @NSManaged public func removeFromCast(at indexes: NSIndexSet)

    @objc(replaceObjectInCastAtIndex:withObject:)
    @NSManaged public func replaceCast(at idx: Int, with value: CastMember)

    @objc(replaceCastAtIndexes:withCast:)
    @NSManaged public func replaceCast(at indexes: NSIndexSet, with values: [CastMember])

    @objc(addCastObject:)
    @NSManaged public func addToCast(_ value: CastMember)

    @objc(removeCastObject:)
    @NSManaged public func removeFromCast(_ value: CastMember)

    @objc(addCast:)
    @NSManaged public func addToCast(_ values: NSOrderedSet)

    @objc(removeCast:)
    @NSManaged public func removeFromCast(_ values: NSOrderedSet)

}

// MARK: Generated accessors for crew
extension Movie {

    @objc(insertObject:inCrewAtIndex:)
    @NSManaged public func insertIntoCrew(_ value: CrewMember, at idx: Int)

    @objc(removeObjectFromCrewAtIndex:)
    @NSManaged public func removeFromCrew(at idx: Int)

    @objc(insertCrew:atIndexes:)
    @NSManaged public func insertIntoCrew(_ values: [CrewMember], at indexes: NSIndexSet)

    @objc(removeCrewAtIndexes:)
    @NSManaged public func removeFromCrew(at indexes: NSIndexSet)

    @objc(replaceObjectInCrewAtIndex:withObject:)
    @NSManaged public func replaceCrew(at idx: Int, with value: CrewMember)

    @objc(replaceCrewAtIndexes:withCrew:)
    @NSManaged public func replaceCrew(at indexes: NSIndexSet, with values: [CrewMember])

    @objc(addCrewObject:)
    @NSManaged public func addToCrew(_ value: CrewMember)

    @objc(removeCrewObject:)
    @NSManaged public func removeFromCrew(_ value: CrewMember)

    @objc(addCrew:)
    @NSManaged public func addToCrew(_ values: NSOrderedSet)

    @objc(removeCrew:)
    @NSManaged public func removeFromCrew(_ values: NSOrderedSet)

}

// MARK: Generated accessors for pages
extension Movie {

    @objc(addPagesObject:)
    @NSManaged public func addToPages(_ value: Page)

    @objc(removePagesObject:)
    @NSManaged public func removeFromPages(_ value: Page)

    @objc(addPages:)
    @NSManaged public func addToPages(_ values: NSSet)

    @objc(removePages:)
    @NSManaged public func removeFromPages(_ values: NSSet)

}

// MARK: Generated accessors for trailers
extension Movie {

    @objc(addTrailersObject:)
    @NSManaged public func addToTrailers(_ value: Video)

    @objc(removeTrailersObject:)
    @NSManaged public func removeFromTrailers(_ value: Video)

    @objc(addTrailers:)
    @NSManaged public func addToTrailers(_ values: NSSet)

    @objc(removeTrailers:)
    @NSManaged public func removeFromTrailers(_ values: NSSet)

}
