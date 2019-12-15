//
//  FileManager.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 11/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

protocol FileManaging {
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey: Any]?) -> Bool
    func contents(atPath path: String) -> Data?
    func removeItem(atPath path: String) throws
    func createDirectory(atPath path: String, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws
}

extension FileManager: FileManaging {
}
