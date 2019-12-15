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
        sut = Repository(path: Location.cache.path, fileManager: fileManager)
    }

    override func tearDown() {
        fileManager = nil
        sut = nil

        super.tearDown()
    }

    /// It should create a directory in the caches folder of the user its home directory.
    func testRepositoryCreatesHomeDirectory() {
        assertFile(path: fileManager.createDirectoryPath, contains: "/Library/Caches/discovermovies")
        XCTAssertEqual(fileManager.createDirectoryAtPathCallCount, 1)
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
            XCTAssertNotNil(self.fileManager.createFileData)
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

    /// It should call into the file manager to restore the data with the right path
    func testRestoresFileFromFolder() throws {
        let identifier = UUID().uuidString
        let object: MockData? = sut.restoreData(forIdentifier: identifier)
        XCTAssertEqual(fileManager.contentsAtPathCallCount, 1)
        assertFile(path: fileManager.path, contains: identifier)
    }

    /// It should return the decoded object when the data is found and can be restored.
    func testRestoresObject() throws {
        let identifier = UUID().uuidString
        let data = try XCTUnwrap(JSONSerialization.data(withJSONObject: ["identifier": identifier], options: []))
        fileManager.content = data

        let object: MockData? = sut.restoreData(forIdentifier: identifier)
        XCTAssertNotNil(object)
    }

    /// It should call into the filemanager to remove the item with the right path.
    func testRemovesItemAtPath() {
        let identifier = UUID().uuidString
        sut.clearData(withIdentifier: identifier)

        let predicate = NSPredicate(format: "removeItemAtPathCallCount == 1")
        let expectation = self.expectation(for: predicate, evaluatedWith: fileManager, handler: nil)

        wait(for: [expectation], timeout: 5.0)
        assertFile(path: fileManager.removeItemPath, contains: identifier)
    }

    // MARK: Helpers

    private func assertFile(path: String?, contains subPath: String,  file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(path?.contains(subPath), true, "\(subPath) is not a sub path of \(String(describing: path))")
    }
}
