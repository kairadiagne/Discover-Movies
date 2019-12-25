//
//  ListUpdaterTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 20/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class ListUpdaterTests: BaseTestCase {

    private var list: List!
    private var sut: ListUpdater!

    override func setUp() {
        super.setUp()

        list = List.list(ofType: .popular, in: viewContext)
        sut = ListUpdater(backgroundContext: viewContext)
    }

    override func tearDown() {
        list = nil
        sut = nil

        super.tearDown()
    }

    /// It should update the list correctly with the result of an API call.
    func testUpdateWithAPIResult() throws {
        let result = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)
        try sut.updateList(of: list.type, with: result)

        XCTAssertEqual(list.page, 1)
        XCTAssertEqual(list.totalPages, 500)
        XCTAssertEqual(list.resultCount, 10000)
        XCTAssertEqual(list.movies.count, 20)
    }

    /// It should add movies in the right order.
    func testAddsMoviesInTheRightOrder() throws {
        let resultPage1 = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)
        let resultPage2 = try MockedData.movieListResponsePageTwo.mapToModel(of: TMDBResult<TMDBMovie>.self)

        try sut.updateList(of: list.type, with: resultPage1)
        try sut.updateList(of: list.type, with: resultPage2)

        let firstMovieListData = try XCTUnwrap(list.movies.firstObject as? MovieListData)
        let lastMovieListData = try XCTUnwrap(list.movies.lastObject as? MovieListData)

        XCTAssertEqual(list.movies.count, 40)
        XCTAssertEqual(firstMovieListData.order, 0)
        XCTAssertEqual(firstMovieListData.movie.title, "Jumanji: The Next Level")
        XCTAssertEqual(lastMovieListData.order, 39)
        XCTAssertEqual(lastMovieListData.movie.title, "Avengers: Infinity War")
    }

    /// It should delete all movies in the list before updating it when it is updated with the first page.
    func testDeletesAllMoviesInListBeforeUpdateWithFirstPage() throws {
        let resultPage1 = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)
        let resultPage2 = try MockedData.movieListResponsePageTwo.mapToModel(of: TMDBResult<TMDBMovie>.self)

        try sut.updateList(of: list.type, with: resultPage2)
        let initialMovies = list.movies.array
        try sut.updateList(of: list.type, with: resultPage1)

        let firstMovieListData = try XCTUnwrap(list.movies.firstObject as? MovieListData)
        let lastMovieListData = try XCTUnwrap(list.movies.lastObject as? MovieListData)

        for movieListData in initialMovies {
            let movieListData = movieListData as! MovieListData
            XCTAssertNil(movieListData.managedObjectContext)
        }

        XCTAssertEqual(list.movies.count, 20)
        XCTAssertEqual(firstMovieListData.order, 0)
        XCTAssertEqual(firstMovieListData.movie.title, "Jumanji: The Next Level")
        XCTAssertEqual(lastMovieListData.order, 19)
        XCTAssertEqual(lastMovieListData.movie.title, "One Piece: Stampede")
    }
}
