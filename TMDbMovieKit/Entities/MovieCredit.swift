//
//  MovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieCredit: DictionaryRepresentable {
    
    // MARK: Properties
    
    public let creditID: Int
    public private(set) var cast: [CastMember]
    public private(set) var crew: [CrewMember]
    public private(set) var director: CrewMember?
    
    // MARK: Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let creditID = dict["id"] as? Int,
            castDicts = dict["cast"] as? [[String: AnyObject]],
            crewDicts = dict["crew"] as? [[String: AnyObject]] else {
                return nil
        }
        
        self.creditID = creditID
        self.cast = []
        self.crew = []
        
        for castDict in castDicts {
            var castMembers = [CastMember]()
            
            if let castMember = CastMember(dictionary: castDict) {
                castMembers.append(castMember)
            }
            
            self.cast = castMembers
        }
        
        for crewDict in crewDicts {
            var crewMembers = [CrewMember]()
            
            if let crewMember = CrewMember(dictionary: crewDict) {
                crewMembers.append(crewMember)
            }
            
            self.crew = crewMembers
        }
        
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }
    
}




