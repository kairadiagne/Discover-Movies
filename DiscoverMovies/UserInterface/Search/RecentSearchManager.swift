//
//  RecentSearchManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class RecentSearchManager {
    
    // MARK: - Properties
    
    var recentSearches = [String]() {
        didSet {
            self.saveToDefaults()
        }
    }
    
    // MARK: - Initialize
    
    init() {
        if let recentSearches = loadFromDefaults() {
            self.recentSearches = recentSearches
        }
    }
    
    // MARK: - Persistence
    
    fileprivate func saveToDefaults() {
        UserDefaults.standard.set(recentSearches, forKey: "recentSearches")
    }
    
    fileprivate func loadFromDefaults() -> [String]? {
        return UserDefaults.standard.array(forKey: "recentSearches") as? [String]
    }
    
}
