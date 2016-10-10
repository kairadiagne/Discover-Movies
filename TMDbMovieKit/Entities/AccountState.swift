//
//  AccountState.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct AccountState: DictionarySerializable {
    
    // MARK: - Properties
    
    public let favoriteStatus: Bool
    public let watchlistStatus: Bool
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let favoriteStatus = dict["favorite"] as? Bool,
            let watchlistStatus =  dict["watchlist"] as? Bool else {
                return nil
        }
        
        self.favoriteStatus = favoriteStatus
        self.watchlistStatus = watchlistStatus
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        // No need to archive an AccountState
        return [:]
    }
}

