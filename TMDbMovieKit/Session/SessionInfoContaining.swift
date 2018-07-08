//
//  SessionInfoContaining.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 11-06-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation

protocol SessionInfoReading {
    var sessionID: String? { get }
    var APIKey: String { get }
    var user: User? { get set } // Remove 
}

protocol SessionInfoMutating {
    func saveSessionID(_ sessionID: String)
    func clearUserData()
}

typealias SessionInfoContaining = SessionInfoReading & SessionInfoMutating
