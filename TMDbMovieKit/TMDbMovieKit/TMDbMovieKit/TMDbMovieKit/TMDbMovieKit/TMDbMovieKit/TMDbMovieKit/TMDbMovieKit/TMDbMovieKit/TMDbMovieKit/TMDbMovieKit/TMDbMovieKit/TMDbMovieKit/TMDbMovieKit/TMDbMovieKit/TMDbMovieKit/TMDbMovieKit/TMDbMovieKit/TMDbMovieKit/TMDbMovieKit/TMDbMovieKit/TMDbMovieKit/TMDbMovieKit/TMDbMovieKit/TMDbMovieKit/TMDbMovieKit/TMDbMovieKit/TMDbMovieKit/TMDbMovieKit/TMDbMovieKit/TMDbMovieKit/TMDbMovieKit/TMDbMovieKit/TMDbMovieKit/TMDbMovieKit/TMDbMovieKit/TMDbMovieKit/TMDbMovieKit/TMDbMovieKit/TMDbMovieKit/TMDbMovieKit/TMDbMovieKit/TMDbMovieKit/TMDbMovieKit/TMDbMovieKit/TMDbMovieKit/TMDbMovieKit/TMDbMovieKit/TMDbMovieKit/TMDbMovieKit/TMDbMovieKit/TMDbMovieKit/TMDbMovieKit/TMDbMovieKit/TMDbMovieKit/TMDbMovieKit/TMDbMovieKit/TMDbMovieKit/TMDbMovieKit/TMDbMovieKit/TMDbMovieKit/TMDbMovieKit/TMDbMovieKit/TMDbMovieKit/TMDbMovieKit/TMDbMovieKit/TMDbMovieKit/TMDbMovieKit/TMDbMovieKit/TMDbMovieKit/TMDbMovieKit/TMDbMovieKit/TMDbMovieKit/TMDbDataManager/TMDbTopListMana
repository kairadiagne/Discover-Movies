//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class TMDbTopListManager: TMDbListDataManager<TMDbMovie> {
    
    // MARK: Properties
    
    private let movieClient = TMDbMovieClient()
    
    private let movieList: TMDbToplist
    
    // MARK: Initialization 
    
    init(cacheIdentifier: String, topList: TMDbToplist) {
        self.movieList = topList
        super.init(cacheIdentifier: cacheIdentifier)
    }
    
    // MARK: API Calls
    
    override func loadOnline(page: Int) {
        super.loadOnline(page)
        
        movieClient.fetchToplist(movieList, page: page) { (list, error) in
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






