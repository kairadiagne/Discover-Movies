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
    @NSManaged public var type: ListType

    /// Defines the last page that was persisted.
    @NSManaged public var page: Int64

    /// The total amount of movies in the list.
    @NSManaged public var resultCount: Int64

    /// The total amount of pages that can be fetched from the backend.
    @NSManaged public var totalPages: Int64

    /// All the movies belonging to the list.
    @NSManaged public var movies: NSOrderedSet

    var nextPage: Int64? {
        return page < totalPages ? page + 1 : nil
    }

    // MARK: Initialize

    static func list(ofType type: List.ListType, in context: NSManagedObjectContext) -> List {
        guard let existingList = List.fetchSingleObject(in: context, configure: { fetchRequest in
            fetchRequest.predicate = NSPredicate(format: "%K == %ld", #keyPath(List.type), type.rawValue)
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

        setPrimitiveValue(0, forKey: #keyPath(List.page))
        setPrimitiveValue(0, forKey: #keyPath(List.resultCount))
        setPrimitiveValue(0, forKey: #keyPath(List.totalPages))
    }

    // MARK: Convenience

//    // Move to list updater
//    func deleteAllMovies() {
//        for movie in movies {
//            managedObjectContext!.delete(movie as! MovieListData)
//        }
//    }
//
//    // Move to list updater
//    func update(with result: TMDBResult<TMDBMovie>) {
//        let managedObjectContext = self.managedObjectContext!
//
//        page = Int64(result.page)
//        resultCount = Int64(result.resultCount)
//        totalPages = Int64(result.pageCount)
//
//        let movieCount = movies.count
//        for (index, movieData) in result.items.enumerated() {
//            let movie = List.existingMovie(withID: Int64(movieData.identifier), context: managedObjectContext) ?? Movie.insert(into: managedObjectContext, movie: movieData)
//            let movieListData = MovieListData.insert(into: managedObjectContext, list: self, order: Int64(movieCount + index), movie: movie)
//            addToMovies(movieListData)
//        }
//    }
//
//    private static func existingMovie(withID ID: Int64, context: NSManagedObjectContext) -> Movie? {
//        let fetchRequest = Movie.movie(with: ID)
//        return try? context.fetch(fetchRequest).first
//    }
}


// MARK: Generated accessors for movies
extension List {

    @objc(insertObject:inMoviesAtIndex:)
    @NSManaged public func insertIntoMovies(_ value: MovieListData, at idx: Int)

    @objc(insertMovies:atIndexes:)
    @NSManaged public func insertIntoMovies(_ values: [MovieListData], at indexes: NSIndexSet)

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieListData)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)
}
