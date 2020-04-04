//
//  Movie+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import CoreData

public class Movie: NSManagedObject, Managed {

    @objc public enum Genre: Int64 {
        case action = 28
        case adventure = 12
        case animation = 16
        case comedy = 35
        case crime = 80
        case documentary = 99
        case drama = 18
        case family = 10751
        case fantasy = 14
        case foreign = 10769
        case history = 36
        case horror = 27
        case music = 10402
        case mystery = 9648
        case romance = 10749
        case scienceFiction = 878
        case tvMovie = 10770
        case thriller = 53
        case war = 10752
        case western = 37
    }

    // MARK: Properties

    @NSManaged public private(set) var identifier: Int64
    @NSManaged public private(set) var title: String
    @NSManaged public private(set) var overview: String
    @NSManaged public private(set) var releaseDate: String
    @NSManaged public private(set) var genres: [Int64]
    @NSManaged public private(set) var rating: Double
    @NSManaged public private(set) var posterPath: String
    @NSManaged public private(set) var backdropPath: String
    @NSManaged public private(set) var cast: NSOrderedSet
    @NSManaged public private(set) var crew: NSOrderedSet
    @NSManaged public private(set) var lists: NSSet
    @NSManaged public private(set) var trailers: NSSet
    
    public var director: CrewMember? {
        return crew.first(where: { ($0 as! CrewMember).job == "Director" }) as? CrewMember
    }

    // MARK: Initialize

    static func insert(into context: NSManagedObjectContext, movie: TMDBMovie) -> Movie {
        let movieEntity = Movie(context: context)
        movieEntity.identifier = Int64(movie.identifier)
        movieEntity.title = movie.title
        movieEntity.overview = movie.overview
        movieEntity.releaseDate = movie.releaseDate
        movieEntity.genres =  movie.genres.map { Int64($0) }
        movieEntity.rating = movie.rating
        movieEntity.posterPath = movie.posterPath
        movieEntity.backdropPath = movie.backDropPath
        return movieEntity
    }

    // MARK: Lifecycle

    override public func prepareForDeletion() {
        super.prepareForDeletion()
        
        crew.forEach { crewMember in
            deleteCrewMemberIfNeeded(crewMember as! CrewMember)
        }
        
        cast.forEach { castMember in
            deletCastMemberIfNeeded(castMember as! CastMember)
        }
    }
    
    private func deleteCrewMemberIfNeeded(_ crewMember: CrewMember) {
        guard crewMember.movies.count == 1 else {
            return
        }
        
        managedObjectContext?.delete(crewMember)
    }
    
    private func deletCastMemberIfNeeded(_ castMember: CastMember) {
        guard castMember.movies.count == 1 else {
            return
        }
        
        managedObjectContext?.delete(castMember)
    }

    // MARK: Fetch requests

    static func movie(with identifier: Int64) -> NSFetchRequest<Movie> {
        let fetchRequest = Movie.defaultFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %ld", #keyPath(Movie.identifier), identifier)
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
