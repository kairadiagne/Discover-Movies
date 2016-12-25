//
//  TopListDataManageProxy.swift
//  Discover
//
//  Created by Kaira Diagne on 20-11-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TopListDataManageProxy {
    
    // MARK: - Properties
    
    private let popularListManager: TMDbTopListDataManager
    
    private let nowPlayingListManager: TMDbTopListDataManager
    
    private let topratedListManager: TMDbTopListDataManager
    
    private let upcomingListManager: TMDbTopListDataManager
    
    // MARK: - Initialize
    
    public convenience init() {
        self.init(popular: TMDbTopListDataManager(list: .popular),
                  nowPlaying: TMDbTopListDataManager(list: .nowPlaying),
                  topRated: TMDbTopListDataManager(list: .topRated),
                  upcoming: TMDbTopListDataManager(list: .upcoming))
    }
    
    init(popular: TMDbTopListDataManager, nowPlaying: TMDbTopListDataManager, topRated: TMDbTopListDataManager, upcoming: TMDbTopListDataManager) {
        self.popularListManager = popular
        self.nowPlayingListManager = nowPlaying
        self.topratedListManager = topRated
        self.upcomingListManager = upcoming
    }
    
    // MARK: - Managers
    
    public func manager(for list: TMDbTopList) -> TMDbTopListDataManager {
        switch list {
        case .popular:
            return popularListManager
        case .nowPlaying:
            return nowPlayingListManager
        case .topRated:
            return topratedListManager
        case .upcoming:
            return upcomingListManager
        }
    }
    
    public func clearCaches() {
        popularListManager.clear()
        nowPlayingListManager.clear()
        topratedListManager.clear()
        upcomingListManager.clear()
    }
    
    public func register(failureDelegate: DataManagerFailureDelegate) {
        popularListManager.failureDelegate = failureDelegate
        nowPlayingListManager.failureDelegate = failureDelegate
        topratedListManager.failureDelegate = failureDelegate
        upcomingListManager.failureDelegate = failureDelegate
    }
    
    public func addObserver(observer: AnyObject, loadingSelector: Selector, updateSelector: Selector) {
        popularListManager.add(observer: observer, loadingSelector: loadingSelector, updateSelector: updateSelector)
        topratedListManager.add(observer: observer, loadingSelector: loadingSelector, updateSelector: updateSelector)
        upcomingListManager.add(observer: observer, loadingSelector: loadingSelector, updateSelector: updateSelector)
        nowPlayingListManager.add(observer: observer, loadingSelector: loadingSelector, updateSelector: updateSelector)
    }
    
    public func remove(observer: AnyObject) {
        popularListManager.remove(observer: observer)
        topratedListManager.remove(observer: observer)
        upcomingListManager.remove(observer: observer)
        nowPlayingListManager.remove(observer: observer)
    }

}
