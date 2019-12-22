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

    /// It should return nil for the next page if the list is empty.
    func testNextPageNilWhenListIsEmpty() {
        let list = List.list(ofType: .popular, in: viewContext)
        XCTAssertNil(list.nextPage)
    }

    /// It should return the next page if the list is not empty.
    func testNextPageWhenListIsNotEmpty() {
        let list = List.list(ofType: .popular, in: viewContext)
        list.page = 1
        list.totalPages = 10

        XCTAssertEqual(list.nextPage, 2)
    }

    /// It should return nil if were at the end of the list.
    func testNextPageWhenReachedEndOfList() {
        let list = List.list(ofType: .popular, in: viewContext)
        list.page = 10
        list.totalPages = 10

        XCTAssertNil(list.nextPage)
    }
}
