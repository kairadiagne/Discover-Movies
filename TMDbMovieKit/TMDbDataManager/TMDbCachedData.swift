//
//  TMDbCachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class TMDbCachedData<ModelType: DictionaryRepresentable> {
    
    // MARK: Properties
    
    private(set) var data: ModelType?
    
    var needsRefresh: Bool {
        guard let lastUpdate = lastUpdate else { return true }
        return lastUpdate.timeIntervalSinceNow > refreshTimeOut
    }
    private var lastUpdate: NSDate?
    
    private var refreshTimeOut: NSTimeInterval!
    
    // MARK: Initialize
    
    init(refreshTimeOut timeOut: NSTimeInterval = 300) {
        self.refreshTimeOut = timeOut
    }
    
    // MARK: Clear Cache
    
    func addData(data: ModelType) {
        self.data = data
        self.lastUpdate = NSDate()
    }
    
    func clear() {
        self.data = nil
        self.lastUpdate = nil
    }

}

