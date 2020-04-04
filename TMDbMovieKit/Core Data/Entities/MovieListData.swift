//
//  MovieListData.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 06/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import CoreData

/// Contains additional information about a movie which belongs to a list.
public class MovieListData: NSManagedObject, Managed {

    // MARK: Properties

    @NSManaged public var order: Int64
    @NSManaged public var list: List
    @NSManaged public var movie: Movie

    // MARK: Initialize

    static func insert(into context: NSManagedObjectContext, list: List, order: Int64, movie: Movie) -> MovieListData {
        let movieListData = MovieListData(context: context)
        movieListData.list = list
        movieListData.order = order
        movieListData.movie = movie
        return movieListData
    }

    // MARK: Lifecycle

    override public func prepareForDeletion() {
        super.prepareForDeletion()

        guard movie.lists.count == 1 else { return }

        managedObjectContext?.delete(movie)
    }

    // MARK: Fetch requests

    static func moviesSortedIn(listOf listType: List.ListType) -> NSFetchRequest<MovieListData> {
        let fetchRequest = MovieListData.defaultFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %ld", #keyPath(MovieListData.list.type), listType.rawValue)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \MovieListData.order, ascending: true)]
        return fetchRequest
    }
}
