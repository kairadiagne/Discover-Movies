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
    
    private let movieClient = TMDbMovieClient()
    
    private let list: TMDbAccountList
    
    // MARK: Intialization 
    
    init(cacheIdentifier: String, list: TMDbAccountList) {
        self.list = list
        super.init(cacheIdentifier: cacheIdentifier)
    }
    
    // MARK: API Calls
    
    override func loadOnline(page: Int) {
        startLoading()
        
        movieClient.fetchAccountList(list, page: page) { (list, error) in
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