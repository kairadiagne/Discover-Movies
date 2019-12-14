//
//  List+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

public class List: NSManagedObject, Managed {

    @objc public enum ListType: Int64 {
        /// The list with popular movies
        case popular
        /// The list with top rated movies
        case topRated
        /// The list with upcoming movies
        case upcoming
        /// The list with movies that are now playing in theathers.
        case nowPlaying
        /// The list with movies that the user has favorited.
        case favorite
        /// The list with movies that the user wants to watch.
        case watchlist
    }

    // MARK: Properties

    /// The type of the list for example the users favorite list.
    @NSManaged public private(set) var type: ListType

    /// Defines the last page that was persisted.
    @NSManaged public private(set) var page: Int64

    /// The total amount of movies in the list.
    @NSManaged public private(set) var resultCount: Int64

    /// The total amount of pages that can be fetched from the backend.
    @NSManaged public private(set) var totalPages: Int64

    /// All the movies belonging to the list.
    @NSManaged public private(set) var movies: NSOrderedSet

    var nextPage: Int64? {
         return page < resultCount ? page + 1 : nil
     }

    // MARK: Primitive properties

    @NSManaged private var primitivePage: Int64
    @NSManaged private var primitiveResultCount: Int64
    @NSManaged private var primitiveTotalPages: Int64
    @NSManaged private var primitiveMovies: NSSet

    // MARK: Initialize

    static func list(ofType type: List.ListType, in context: NSManagedObjectContext) -> List {
        guard let existingList = List.fetchSingleObject(in: context, configure: { fetchRequest in
            fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(List.type), type.rawValue)
        }) else {
            return insert(into: context, type: type)
        }

        return existingList
    }

    private static func insert(into context: NSManagedObjectContext, type: List.ListType) -> List {
        let list = List(context: context)
        list.type = type
        return list
    }

    // MARK: Lifecycle

    override public func awakeFromInsert() {
        super.awakeFromInsert()

        primitivePage = 0
        primitiveResultCount = 0
        primitiveTotalPages = 0
        primitiveMovies = []
    }

    // MARK: Convenience

    func deleteAllMovies() {
        for movie in movies {
            managedObjectContext!.delete(movie as! MovieListData)
        }
    }

    func update(with result: TMDBResult<TMDBMovie>) {
        let managedObjectContext = self.managedObjectContext!

        page = Int64(result.page)
        resultCount = Int64(result.resultCount)
        totalPages = Int64(result.pageCount)

        for (index, movieData) in result.items.reversed().enumerated() {
            let movie = Movie.insert(into: managedObjectContext, list: self, movie: movieData)
            let movieListData = MovieListData.insert(into: managedObjectContext, list: self, order: Int64(index), movie: movie)
            addToMovies(movieListData)
        }
    }
}

// MARK: Generated accessors for movies
extension List {

    @objc(insertObject:inMoviesAtIndex:)
    @NSManaged public func insertIntoMovies(_ value: MovieListData, at idx: Int)

    @objc(removeObjectFromMoviesAtIndex:)
    @NSManaged public func removeFromMovies(at idx: Int)

    @objc(insertMovies:atIndexes:)
    @NSManaged public func insertIntoMovies(_ values: [MovieListData], at indexes: NSIndexSet)

    @objc(removeMoviesAtIndexes:)
    @NSManaged public func removeFromMovies(at indexes: NSIndexSet)

    @objc(replaceObjectInMoviesAtIndex:withObject:)
    @NSManaged public func replaceMovies(at idx: Int, with value: MovieListData)

    @objc(replaceMoviesAtIndexes:withMovies:)
    @NSManaged public func replaceMovies(at indexes: NSIndexSet, with values: [MovieListData])

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieListData)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieListData)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
