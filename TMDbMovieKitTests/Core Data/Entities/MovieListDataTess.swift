//
//  MovieListDataTess.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 23/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class MovieListDataTess: BaseTestCase {

    /// It should cascade a delete to its movie object when that movie does not belong to any other lists.
    func testDeletesMovieIfNotInAnyOtherList() throws {
        let popularList = List.list(ofType: .popular, in: viewContext)
        let rawMovie = try MockedData.movie.mapToModel(of: TMDBMovie.self)
        let movieEntity = Movie.insert(into: viewContext, movie: rawMovie)
        let movieListData = MovieListData.insert(into: viewContext, list: popularList, order: 1, movie: movieEntity)

        try viewContext.save()
        viewContext.delete(movieListData)

        assert(deletesMovie: true, movie: movieEntity)
    }

    /// It should not cascade a delete to the movie if the movie still belongs to any other lists.
    func testDoesNotDeleteMovieIfAlsoInOtherList() throws {
        let popularList = List.list(ofType: .popular, in: viewContext)
        let upcomingList = List.list(ofType: .nowPlaying, in: viewContext)

        let rawMovie = try MockedData.movie.mapToModel(of: TMDBMovie.self)
        let movieEntity = Movie.insert(into: viewContext, movie: rawMovie)

        let movieListData = MovieListData.insert(into: viewContext, list: popularList, order: 1, movie: movieEntity)
        _ = MovieListData.insert(into: viewContext, list: upcomingList, order: 1, movie: movieEntity)

        try viewContext.save()
        viewContext.delete(movieListData)

        assert(deletesMovie: false, movie: movieEntity)
    }

    // MARK: Helpers

    private func assert(deletesMovie: Bool, movie: Movie, file: StaticString = #file, line: UInt = #line) {
        let predicate = NSPredicate { object, _ -> Bool in
            return (object as? Movie)?.isDeleted == true
        }

        let expectation = self.expectation(for: predicate, evaluatedWith: movie, handler: nil)
        expectation.isInverted = !deletesMovie
        wait(for: [expectation], timeout: 3.0)
    }
}
