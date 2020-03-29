//
//  KeyValueStorageMock.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 29/03/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

@testable import TMDbMovieKit

final class KeyValueStorageMock: KeyValueStorage {
    
    private var dictionary: [String: Any?]
    
    init(initialValues: [String: Any] = [:]) {
        dictionary = initialValues
    }
    
    func bool(forKey defaultName: String) -> Bool {
        return dictionary[defaultName] as? Bool ?? false
    }
    
    func string(forKey defaultName: String) -> String? {
        return dictionary[defaultName] as? String
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        dictionary[defaultName] = value
    }
}
