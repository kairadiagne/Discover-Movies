//
//  Movie+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

public class Movie: NSManagedObject, Managed {
    
    // MARK: Properties

    @NSManaged public private(set) var identifier: Int64
    @NSManaged public private(set) var title: String
    @NSManaged public private(set) var overview: String
    @NSManaged public private(set) var releaseDate: String
    @NSManaged public private(set) var genres: Int64
    @NSManaged public private(set) var rating: Double
    @NSManaged public private(set) var posterPath: String
    @NSManaged public private(set) var backdropPath: String
    @NSManaged public private(set) var cast: NSOrderedSet
    @NSManaged public private(set) var crew: NSOrderedSet
    @NSManaged public private(set) var lists: NSSet
    @NSManaged public private(set) var trailers: NSSet

    // MARK: Initialize

    static func insert(into context: NSManagedObjectContext, movie: TMDBMovie) -> Movie {
        let newMovie = Movie(context: context)
        newMovie.identifier = Int64(movie.identifier)
        newMovie.title = movie.title
        newMovie.overview = movie.overview
        newMovie.releaseDate = movie.releaseDate
        newMovie.genres =  1 // Int64(movie.genres.first ?? 1) // Fix
        newMovie.rating = movie.rating
        newMovie.posterPath = movie.posterPath
        newMovie.backdropPath = movie.backDropPath
        return newMovie
    }

    // MARK: Lifecycle

    override public func prepareForDeletion() {
        super.prepareForDeletion()

        // Delete all crew members which don't belong to the crew of other movies
        // Delete all cast members which don;t belong to the crew of other movies. 
    }

    // MARK: Fetch requests

    static func movie(with id: Int64) -> NSFetchRequest<Movie> {
        let fetchRequest = Movie.defaultFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %ld", #keyPath(Movie.identifier), id)
        fetchRequest.fetchLimit = 1
        return fetchRequest
    }
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

// MARK: Generated accessors for lists
extension Movie {

    @objc(addListsObject:)
    @NSManaged public func addToLists(_ value: MovieListData)

    @objc(removeListsObject:)
    @NSManaged public func removeFromLists(_ value: MovieListData)

    @objc(addLists:)
    @NSManaged public func addToLists(_ values: NSSet)

    @objc(removeLists:)
    @NSManaged public func removeFromLists(_ values: NSSet)

}
