//
//  TMDbCachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class TMDbCachedData<ModelType: DictionaryRepresentable>: NSObject, NSCoding {
    
    // MARK: - Properties
    
    private(set) var data: ModelType?
    
    var needsRefresh: Bool {
        guard let lastUpdate = lastUpdate else { return true }
        return lastUpdate.timeIntervalSinceNow > refreshTimeOut
    }
    
    private var lastUpdate: NSDate?
    
    private var refreshTimeOut: NSTimeInterval = 300
    
    // MARK: - Initialize
    
    init(refreshTimeOut timeOut: NSTimeInterval = 300) {
        self.refreshTimeOut = timeOut
        super.init()
    }
    
    // MARK: - Clear Cache
    
    func addData(data: ModelType) {
        self.data = data
        self.lastUpdate = NSDate()
    }
    
    func clear() {
        self.data = nil
        self.lastUpdate = nil
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        guard let dataDict = aDecoder.decodeObjectForKey("data") as? [String: AnyObject] else { return nil }
        self.data = ModelType(dictionary: dataDict)
        self.lastUpdate = aDecoder.decodeObjectForKey("lastUpdate") as? NSDate
        self.refreshTimeOut = aDecoder.decodeObjectForKey("timeOut") as? NSTimeInterval ?? 300
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(data?.dictionaryRepresentation(), forKey: "data")
        aCoder.encodeObject(lastUpdate, forKey: "lastUpdate")
        aCoder.encodeObject(refreshTimeOut, forKey: "timeOut")
    }

}

