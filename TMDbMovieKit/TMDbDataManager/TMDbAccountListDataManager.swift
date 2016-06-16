//
//  TMDbAccountListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbAccountListDataManager: TMDbBaseDataManager {
    
    // MARK: Properties
    
    public var movies: [TMDbMovie] {
        return list.items
    }
    
    private let movieClient = TMDbMovieClient()
    
    private var currentList: TMDbAccountList?
    
    private var list = TMDbList<TMDbMovie>()
    
    // MARK: Fetching 
    
    public func loadTop(list: TMDbAccountList) {
        currentList = list
        fetchList(list, page: 1)
        
    }
    
    public func loadMore() {
        guard !isLoading else { return }
        guard let currentList = currentList else { return }
        guard let nextPage = list.nextPage else { return }
        fetchList(currentList, page: nextPage)
    }
    
    // MARK: API Calls 
    
    private func fetchList(list: TMDbAccountList, page: Int) {
        guard let _ = currentList else { return }
        
        isLoading = true
        
        movieClient.fetchAccountList(list, page: page) { (list, error) in
            self.isLoading = false
            
            guard error == nil else {
                print(error)
                self.postErrorNotification(error!)
                return
            }
            
            if let results = list {
                self.updateList(self.list, withData: results)
            }
        }

    }
    
}