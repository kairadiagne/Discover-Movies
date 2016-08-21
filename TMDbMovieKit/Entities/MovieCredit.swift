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
    
    public private(set) var cast: [CastMember] = []
    public private(set) var crew: [CrewMember] = []
    
    // MARK: Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let castDicts = dict["cast"] as? [[String: AnyObject]],
            crewDicts = dict["crew"] as? [[String: AnyObject]] else {
                return nil
        }
        
        var castMembers = [CastMember]()
        
        for castDict in castDicts {
            
            if let castMember = CastMember(dictionary: castDict) {
                castMembers.append(castMember)
            }
            
        }
        
        self.cast = castMembers
        
        var crewMembers = [CrewMember]()
        
        for crewDict in crewDicts {
            
            if let crewMember = CrewMember(dictionary: crewDict) {
                crewMembers.append(crewMember)
            }
            
        }
        
        self.crew = crewMembers
        
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        // No need to archive a MovieCredit
        return [:]
    }
    
}




