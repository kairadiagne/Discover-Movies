//
//  ListController.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 20/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import CoreData

final class ListController {

    typealias Completion = (Result<Void, Error>) -> Void

    private let backgroundContext: NSManagedObjectContext

    init(backgroundContext: NSManagedObjectContext) {
        self.backgroundContext = backgroundContext
    }

    func updateList(of type: List.ListType, with result: TMDBResult<TMDBMovie>, completion: @escaping Completion) {
        backgroundContext.perform {
            let list = List.list(ofType: type, in: self.backgroundContext)

            if result.page == 1 {
                self.deleteAllMovies(in: list)
                self.update(list: list, with: result)
            } else if result.page > list.page {
                self.update(list: list, with: result)
            }

            do {
                try self.backgroundContext.save()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }

    private func deleteAllMovies(in list: List) {
        for movie in list.movies {
            backgroundContext.delete(movie as! MovieListData)
        }
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
