//
//  PersonInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Person: DictionarySerializable {
    
    // MARK: - Types
    
    public enum Gender: Int {
        case man = 1 // 2
        case woman = 2 //
    }
    
    // MARK: - Properties
    
    public let personID: Int
    public var imdbID: String?
    public let name: String
    public var birthDay: String?
    public var deathDay: String?
    public var birthPlace: String?
    public var biography: String?
    public var gender: Gender?
    public let adult: Bool
    public var profilePath: String?
    public var homepage: String?
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let personID = dict["id"] as? Int,
            let imdbID = dict["imdb_id"] as? String,
            let name = dict["name"] as? String,
            let adult = dict["adult"] as? Bool else {
                return nil
        }
        
        self.personID = personID
        self.imdbID = imdbID
        self.name = name
        self.birthDay = dict["birthday"] as? String
        self.deathDay = dict["deathday"] as? String
        self.birthPlace = dict["place_of_birth"] as? String
        self.biography = dict["biography"] as? String
        self.adult = adult
        self.profilePath = dict["profile_path"] as? String
        self.homepage = dict["homepage"] as? String
  
        if let genderRaw = dict["gender"] as? Int {
           self.gender = Gender(rawValue: genderRaw)
        }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }

}

