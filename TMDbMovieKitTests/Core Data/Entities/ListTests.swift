//
//  ListTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 15/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class ListTests: BaseTestCase {

    /// It should have the correct default values set if the list is empty.
    func testDefaultValuesEmptyList() {
        let list = List.list(ofType: .popular, in: viewContext)
        XCTAssertEqual(list.type, .popular)
        XCTAssertEqual(list.page, 0)
        XCTAssertEqual(list.resultCount, 0)
        XCTAssertEqual(list.totalPages, 0)
        XCTAssertEqual(list.movies.count, 0)
    }

    /// It should return an existing list if one already exists.
    func testReturnsExistingListIfAlreadyExists() throws {
        let listType = List.ListType.popular
        let list = List.list(ofType: listType, in: viewContext)
        try viewContext.save()
        let sameList = List.list(ofType: listType, in: viewContext)

        let fetchRequest = List.defaultFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %ld", #keyPath(List.type), listType.rawValue)

        XCTAssertEqual(try viewContext.count(for: fetchRequest), 1)
        XCTAssertEqual(list, sameList)
    }

    /// It should update the list correctly with the result of an API call.
    func testUpdateWithAPIResult() throws {
        let list = List.list(ofType: .popular, in: viewContext)
        let result = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)

        list.update(with: result)

        XCTAssertEqual(list.page, 1)
        XCTAssertEqual(list.totalPages, 500)
        XCTAssertEqual(list.resultCount, 10000)
        XCTAssertEqual(list.movies.count, 20)
    }

    /// It should add movies in the right order.
    func testAddsMoviesInTheRightOrder() throws {
        let list = List.list(ofType: .popular, in: viewContext)
        let result = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)

        list.update(with: result)

        let firstMovieListData = try XCTUnwrap(list.movies.firstObject as? MovieListData)
        let lastMovieListData = try XCTUnwrap(list.movies.lastObject as? MovieListData)

        XCTAssertEqual(firstMovieListData.order, 0)
        XCTAssertEqual(firstMovieListData.movie.title, "Jumanji: The Next Level")
        XCTAssertEqual(lastMovieListData.order, 19)
        XCTAssertEqual(lastMovieListData.movie.title, "One Piece: Stampede")
    }

    /// It should return nil for the next page if the list is empty.
    func testNextPageNilWhenListIsEmpty() {
        let list = List.list(ofType: .popular, in: viewContext)
        XCTAssertNil(list.nextPage)
    }

    /// It should return the next page if the list is not empty.
    func testNextPageWhenListIsNotEmpty() throws {
        let list = List.list(ofType: .popular, in: viewContext)
        let result = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)
        list.update(with: result)

        XCTAssertEqual(list.nextPage, 2)
    }

    /// It should delete all the movies in the list.
    func testDeleteAllMovies() throws {
        let list = List.list(ofType: .popular, in: viewContext)
        let result = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)
        list.update(with: result)

        list.deleteAllMovies()
        try viewContext.save()

        XCTAssertEqual(list.movies.count, 0)
    }
}
