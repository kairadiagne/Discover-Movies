//
//  CastMember+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import CoreData

public final class CastMember: NSManagedObject {

    // MARK: Properties

    @NSManaged public var identifier: Int64
    @NSManaged public var castIdentifier: Int64
    @NSManaged public var name: String
    @NSManaged public var character: String
    @NSManaged public var order: Int64
    @NSManaged public var profilePath: String?
    @NSManaged public var movies: NSSet
    
    // MARK: Initialize

    static func insert(into context: NSManagedObjectContext, castMember: TMDBCastMember, movie: Movie) -> CastMember {
        let newCastMember = CastMember(context: context)
        newCastMember.identifier = Int64(castMember.identifier)
        newCastMember.castIdentifier = Int64(castMember.castID)
        newCastMember.character = castMember.character
        newCastMember.order = Int64(castMember.order)
        newCastMember.profilePath = castMember.profilePath
        newCastMember.addToMovies(movie)
        return newCastMember
    }
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
