//
//  DictionaryRepresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol DictionaryRepresentable {
    init?(dictionary dict: [String: AnyObject])
    func dictionaryRepresentation() -> [String: AnyObject]
}