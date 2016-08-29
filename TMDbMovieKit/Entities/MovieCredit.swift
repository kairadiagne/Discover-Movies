//
//  MovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieCredit: DictionaryRepresentable {
    
    // MARK: - Properties
    
    public private(set) var cast: [CastMember] = []
    public private(set) var crew: [CrewMember] = []
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let castDicts = dict["cast"] as? [[String: AnyObject]],
            crewDicts = dict["crew"] as? [[String: AnyObject]] else {
                return nil
        }
        
        self.cast = castDicts.map { return CastMember(dictionary: $0) }.flatMap { $0 }
        self.crew = crewDicts.map { return CrewMember(dictionary: $0) }.flatMap { $0 }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        // No need to archive a MovieCredit
        return [:]
    }
    
}




