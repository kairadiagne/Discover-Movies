//
//  PersonInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol PersonRepresentable {
    var id: Int { get }
    var name: String { get }
    var profilePath: String? { get }
}

public struct Person: PersonRepresentable, Equatable {
    public let id: Int
    public let imdbId: String
    public let name: String
    public var gender: Int?
    public let adult: Bool?
    public var birthDay: String?
    public var birthPlace: String?
    public var deathDay: String?
    public var biography: String?
    public var homepage: URL?
    public private(set) var profilePath: String?
    public private(set) var movieCredits: [MovieCredit] = []
}

public func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.id == rhs.id
}

extension Person: DictionarySerializable {
    
    public init?(dictionary dict: [String: AnyObject]) {
        guard let id = dict["id"] as? Int,
            let imdbId = dict["imdb_id"] as? String,
            let name = dict["name"] as? String,
            let adult = dict["adult"] as? Bool else {
                return nil
        }
      
        self.id = id
        self.imdbId = imdbId
        self.name = name
        self.gender = dict["gender"] as? Int
        self.birthDay = dict["birthday"] as? String
        self.deathDay = dict["deathday"] as? String
        self.birthPlace = dict["place_of_birth"] as? String
        self.biography = dict["biography"] as? String
        self.adult = adult
        self.profilePath = dict["profile_path"] as? String
        
        if let rawValue = dict["homepage"] as? String {
            if rawValue.count != 0 {
                if let homepage = URL(string: rawValue) {
                    self.homepage = homepage
                }
            }
        }
       
        if let movieCredits = dict["movie_credits"] as? [String: AnyObject] {
            if let castDicts = movieCredits["cast"] as? [[String: AnyObject]] {
                self.movieCredits = castDicts.compactMap { MovieCredit(dictionary: $0) }
            }
            
            if let crewDicts = movieCredits["crew"] as? [[String: AnyObject]] {
                let credits = crewDicts.compactMap { MovieCredit(dictionary: $0) }
                self.movieCredits.append(contentsOf: credits)
            }
        }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }
}
