//
//  SessionInfoContaining.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

protocol SessionInfoContaining {
    var sessionID: String? { get }
    func saveSessionID(_ sessionID: String)
    var APIKey: String { get }
    func saveAPIKey(_ key: String)
    var user: User? { get }
    func save(user: User)
    func clearUserData()
}
