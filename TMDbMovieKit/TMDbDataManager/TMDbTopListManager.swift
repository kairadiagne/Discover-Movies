//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

protocol TMDbDataManager: class {
    var inProgress: Bool { get set }
    func postUpdateNotification()
    func postChangeNotification()
    func postErrorNotification(error: NSError)
}

public class TMDbTopListManager: TMDbDataManager {
    
    // Classes that confom to NSCoding can be serialized and deserialized into data that can be either be achived to diskor distributed across a network.
    // Of course serialization is only one part of the story. Determining where this data will persist is another question.
    // There are two approachs: writing to the local file system and using NSUserdefaults.
    
    // NSkeyedArchiver and NSkeyedUnArchiver provide a convenient API to read / write objects directly to / from disk.
    // We  can set its collection property from the file manager:
    // NSKeyedArchiver.archiveRootObject(books, toFile: "/path/to/archive")
    // NSKeyedUnarchiver.unarchiveObjectWithFile("/path/to/archive") as? [Book] else { return nil }
    
    // Public properties
    
    public var movies: [TMDbMovie] {
        guard let currentList = currentList else { return [] }
        
        switch currentList {
        case .Popular:
            return popular.items
        case .TopRated:
            return topRated.items
        case .Upcoming:
            return upcoming.items
        case .NowPlaying:
            return nowPlaying.items
        }
        
    }
    
    public var inProgress: Bool = false
    
    // Private properties
    
    private let movieClient = TMDbMovieClient()
    
    private var currentList: TMDbToplist?
    
    private var popular = TMDbList<TMDbMovie>()
    
    private var topRated = TMDbList<TMDbMovie>()
    
    private var upcoming = TMDbList<TMDbMovie>()
    
    private var nowPlaying = TMDbList<TMDbMovie>()
    
    // MARK: - Initialization 
    
    public init () { }  
    
    // MARK: - Fetching

    public func reloadTopIfNeeded(forceOnline: Bool, list: TMDbToplist) {
        currentList = list
        
        // if list != loading && list needs refresh 
            // isloading // inprogress
            // Fetch page 1
        //  if forceOnline 
            // isloading // inprogress
            // Fetch page 1
        inProgress = true
        fetchList(list, page: 1)
    }
    
    public func loadMore() {
        guard inProgress == false else { return }
        guard let list = currentList else { return }
    
        // Check which page we need to fetch
        var page: Int
        
        switch list {
        case .Popular:
            page = popular.nextPage ?? 1
        case .TopRated:
            page = topRated.nextPage ?? 1
        case .NowPlaying:
            page = nowPlaying.nextPage ?? 1
        case .Upcoming:
            page = upcoming.nextPage ?? 1
        }
        
        fetchList(list, page: page)
    }
    
    // MARK: Fetching
    
    private func fetchList(list: TMDbToplist, page: Int) {
        guard let currentList = currentList else { return }
        
        inProgress = true
        
        movieClient.fetchToplist(list, page: page) { (response) in
        
            self.inProgress = false
            
            guard response.error == nil else {
                print(response.error)
                self.postErrorNotification(response.error!)
                return
            }
            
            // Update list in cached data 
            
            if let data = response.value {
                switch currentList {
                case .Popular:
                    self.updateList(self.popular, withData: data)
                case .TopRated:
                    self.updateList(self.topRated, withData: data)
                case .Upcoming:
                    self.updateList(self.upcoming, withData: data)
                case .NowPlaying:
                    self.updateList(self.nowPlaying, withData: data)
                }

            }
        }
    }
    
    // MARK: - Handle Response
    
    private func updateList(list: TMDbList<TMDbMovie>, withData data: TMDbList<TMDbMovie>) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
           list.update(data)

            dispatch_async(dispatch_get_main_queue(), {
                if list.page == 1 {
                    self.postUpdateNotification()
                } else if list.page > 1 {
                    self.postChangeNotification()
                }
            })
        }
    }
 
    
    // MARK: - Notifications
    
    func postUpdateNotification() {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbDataManagerNotification.DataDidUpdate.name, object: self)
    }
    
    func postChangeNotification() {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbDataManagerNotification.DataDidChange.name, object: self)
    }
    
    func postErrorNotification(error: NSError) {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbDataManagerNotification.DidReceiveError.name, object: self, userInfo: ["error": error])
    }
    
}

    





