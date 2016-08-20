//
//  TMDbAccountListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbAccountListDataManager: TMDbListDataManager<TMDbMovie> {
    
    // MARK: Properties
    
    public static let shared = TMDbAccountListDataManager()
    
    private let movieClient = TMDbMovieClient()
    
    public var list: TMDbAccountList? {
        didSet {
            if let list = list {
                switch list{
                case .Watchlist:
                    cacheIdentifier = "WatchlistCache"
                case .Favorites:
                    cacheIdentifier = "FavoriteListCache"
                }
            }
        }
    }
    
    // MARK: Initialization
    
    override init() {
        super.init()
    }
    
    // MARK: API Calls
    
    override func loadOnline(page: Int) {
        super.loadOnline(page)
        guard let list = list else { return }
        
        movieClient.fetchAccountList(list, page: page) { (list, error) in
            self.stopLoading()
            guard error == nil else {
                self.handleError(error!)
                return
            }
            
            if let data = list {
                self.update(withData: data)
            }
        }
    }
    
}