//
//  RepositoryTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 14/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class RepositoryTests: XCTestCase {

    private struct MockData: Codable {
        let identifier: String = UUID().uuidString
    }

    private var sut: Repository!
    private var fileManager: FileManagerMock!

    override func setUp() {
        super.setUp()

        fileManager = FileManagerMock()
        sut = Repository(path: Repository.Location.cache.path, fileManager: fileManager)
    }

    override func tearDown() {
        fileManager = nil
        sut = nil

        super.tearDown()
    }

    /// It should create a directory in the caches folder of the user's home directory.
    func testRepositoryCreatesHomeDirectory() {
        assertFile(path: fileManager.createDirectoryPath, contains: "/Library/Caches/discovermovies")
        XCTAssertEqual(fileManager.createIntermediatesDirectories, true)
        XCTAssertNil(fileManager.createDirectoryAttributes)
    }

    /// It should encode an object to data and write it to the right directory on the file system.
    func testPersistObjectToFileSystem() {
        let mockdata = MockData()

        let expectation = self.expectation(description: "The repository should complete")
        sut.persistData(data: mockdata, withIdentifier: mockdata.identifier) { result in
            XCTAssertNil(result.error)
            self.assertFile(path: self.fileManager.createdFilePath, contains: "/Library/Caches/discovermovies/\(mockdata.identifier)")
            XCTAssertNotNil(self.fileManager.createdFileAttributes)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0)
    }

    /// It should complete with an appropriate error when writing the data to the file system has failed.
    func testCompletsWithWriteErrorWhenPersistFails() {
        let mockData = MockData()
        fileManager.createFileReturnValue = false

        let expectation = self.expectation(description: "The repository should complete")
        sut.persistData(data: mockData, withIdentifier: mockData.identifier) { result in
            XCTAssertNotNil(result.error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0)
    }

    /// It should succesfuly restore a file.

    /// It should restore a file from the right path

    /// It should return nil if it can't find a file for the right path

    /// It should remove an item at the right path

    // MARK: Helpers

    private func assertFile(path: String, contains subPath: String,  file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(path.contains(subPath), "\(subPath) is not a sub path of \(path)")
    }
}
