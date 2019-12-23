//
//  List+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

/// Contains all the information about a particular list of movies.
public class List: NSManagedObject, Managed {

    @objc public enum ListType: Int64 {
        case popular
        case topRated
        case upcoming
        case nowPlaying
        case favorite
        case watchlist
    }

    // MARK: Properties

    @NSManaged public var type: ListType
    @NSManaged public var page: Int64
    @NSManaged public var resultCount: Int64
    @NSManaged public var totalPages: Int64
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
}


// MARK: Generated accessors for movies
extension List {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieListData)
}
