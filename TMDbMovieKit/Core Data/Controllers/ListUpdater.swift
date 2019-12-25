//
//  ListUpdater.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 20/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import CoreData

protocol ListUpdating {
    func updateList(of type: List.ListType, with result: TMDBResult<TMDBMovie>) throws
}

struct ListUpdater: ListUpdating {

    // MARK: Properties

    private let backgroundContext: NSManagedObjectContext

    // MARK: Initialize

    init(backgroundContext: NSManagedObjectContext) {
        self.backgroundContext = backgroundContext
    }

    // MARK: ListUpdating

    func updateList(of type: List.ListType, with result: TMDBResult<TMDBMovie>) throws {
        var errorToThrow: Error?

        backgroundContext.performAndWait {
            let list = List.list(ofType: type, in: self.backgroundContext)

            if result.page == 1 {
                self.deleteAllMoviesInListIfNeeded(list)
                self.update(list: list, with: result)
            } else if result.page > list.page {
                self.update(list: list, with: result)
            }

            do {
                try self.backgroundContext.save()
            } catch {
                errorToThrow = error
            }
        }

        if let error = errorToThrow {
            throw error
        }
    }

    // MARK: Helper

    private func deleteAllMoviesInListIfNeeded(_ list: List) {
        guard list.movies.count > 0 else {
            return
        }

        let movies = list.movies.set as NSSet

        movies.forEach { movieListData in
            let movieListData = movieListData as! MovieListData
            backgroundContext.delete(movieListData)
        }

        list.removeFromMovies(movies)
    }

    private func update(list: List, with result: TMDBResult<TMDBMovie>) {
        list.page = Int64(result.page)
        list.resultCount = Int64(result.resultCount)
        list.totalPages = Int64(result.pageCount)

        let movieCount = list.movies.count
        for (index, movieData) in result.items.enumerated() {
            let movie = existingMovie(withID: Int64(movieData.identifier), context: backgroundContext) ?? Movie.insert(into: backgroundContext, movie: movieData)
            let movieListData = MovieListData.insert(into: backgroundContext, list: list, order: Int64(movieCount + index), movie: movie)
            list.addToMovies(movieListData)
        }
    }

    private func existingMovie(withID ID: Int64, context: NSManagedObjectContext) -> Movie? {
        let fetchRequest = Movie.movie(with: ID)
        return try? context.fetch(fetchRequest).first
    }
}
