//
//  FileManagerMock.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 14/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation
@testable import TMDbMovieKit

final class FileManagerMock: FileManaging {

    // MARK: Mock Properties

    private(set) var createdFilePath: String = ""
    private(set) var createFileData: Data?
    private(set) var createdFileAttributes: [FileAttributeKey: Any]?

    private(set) var contentPath: String = ""

    private(set) var removeItemPath: String = ""
    private(set) var createDirectoryPath: String = ""
    private(set) var createIntermediatesDirectories: Bool?
    private(set) var createDirectoryAttributes: [FileAttributeKey: Any]?

    // MARK: Stub properties

    var content: Data?
    var createFileReturnValue = true

    // MARK: FileManaging

    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey : Any]?) -> Bool {
        createdFilePath = path
        createFileData = data
        createdFileAttributes = attr
        return createFileReturnValue
    }

    func contents(atPath path: String) -> Data? {
        contentPath = path
        return content
    }

    func removeItem(atPath path: String) throws {
        removeItemPath = path
    }

    func createDirectory(atPath path: String, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]?) throws {
        createDirectoryPath = path
        createIntermediatesDirectories = createIntermediates
        createDirectoryAttributes = attributes
    }
}
