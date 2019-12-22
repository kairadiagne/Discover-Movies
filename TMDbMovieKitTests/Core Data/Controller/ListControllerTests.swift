//
//  ListControllerTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 20/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class ListControllerTests: BaseTestCase {

    private var list: List!
    private var sut: ListController!

    override func setUp() {
        super.setUp()

        list = List.list(ofType: .popular, in: viewContext)
        sut = ListController(backgroundContext: viewContext)
    }

    override func tearDown() {
        list = nil
        sut = nil

        super.tearDown()
    }

    /// It should update the list correctly with the result of an API call.
    func testUpdateWithAPIResult() throws {
        let result = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)

        let expectation = self.expectation(description: "It should update the list")
        sut.updateList(of: list.type, with: result) { result in
            XCTAssertNil(result.error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3.0, handler: nil)

        XCTAssertEqual(list.page, 1)
        XCTAssertEqual(list.totalPages, 500)
        XCTAssertEqual(list.resultCount, 10000)
        XCTAssertEqual(list.movies.count, 20)
    }

    /// It should add movies in the right order.
    func testAddsMoviesInTheRightOrder() throws {
        let result = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)

        let expectation = self.expectation(description: "It should update the list")
        sut.updateList(of: list.type, with: result) { result in
            XCTAssertNil(result.error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3.0, handler: nil)

        let firstMovieListData = try XCTUnwrap(list.movies.firstObject as? MovieListData)
        let lastMovieListData = try XCTUnwrap(list.movies.lastObject as? MovieListData)

        XCTAssertEqual(firstMovieListData.order, 0)
        XCTAssertEqual(firstMovieListData.movie.title, "Jumanji: The Next Level")
        XCTAssertEqual(lastMovieListData.order, 19)
        XCTAssertEqual(lastMovieListData.movie.title, "One Piece: Stampede")
    }

    /// It should add movies in the right order.
    func testAddsMoviesNewPageInRightOrder() throws {
        let resultPage1 = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)
        let resultPage2 = try MockedData.movieListResponsePageTwo.mapToModel(of: TMDBResult<TMDBMovie>.self)

        let expectation1 = self.expectation(description: "It should update the list")
        sut.updateList(of: list.type, with: resultPage1) { result in
            XCTAssertNil(result.error)
            expectation1.fulfill()
        }

        let expectation2 = self.expectation(description: "It should update the list")
        sut.updateList(of: list.type, with: resultPage2) { result in
            XCTAssertNil(result.error)
            expectation2.fulfill()
        }

        wait(for: [expectation1, expectation2], timeout: 3.0)

        let firstMovieListData = try XCTUnwrap(list.movies.firstObject as? MovieListData)
        let lastMovieListData = try XCTUnwrap(list.movies.lastObject as? MovieListData)

        XCTAssertEqual(list.movies.count, 40)
        XCTAssertEqual(firstMovieListData.order, 0)
        XCTAssertEqual(firstMovieListData.movie.title, "Jumanji: The Next Level")
        XCTAssertEqual(lastMovieListData.order, 39)
        XCTAssertEqual(lastMovieListData.movie.title, "Avengers: Infinity War")
    }

//    /// It should delete all the movies in the list.
//       func testDeleteAllMovies() throws {
//           let list = List.list(ofType: .popular, in: viewContext)
//           let result = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)
//           list.update(with: result)
//
//           list.deleteAllMovies()
//           try viewContext.save()
//
//           XCTAssertEqual(list.movies.count, 0)
//       }
}
