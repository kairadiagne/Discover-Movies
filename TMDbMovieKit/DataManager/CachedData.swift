//
//  CachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class CachedData<ModelType: DictionaryRepresentable>: NSObject, NSCoding {
    
    typealias DataType = ModelType
    
    // MARK: - Properties
    
    var data: ModelType?
    
    var needsRefresh: Bool {
        guard let lastUpdate = lastUpdate else { return true }
        return Date().timeIntervalSince(lastUpdate) > refreshTimeOut
    }
    
    var timeLastUpdated: Date? {
        return lastUpdate
    }
    
    let refreshTimeOut: TimeInterval
    
    fileprivate var lastUpdate: Date?
    
    // MARK: - Initialize
    
    required init(refreshTimeOut timeOut: TimeInterval) {
        self.refreshTimeOut = timeOut
        super.init()
    }
    
    // MARK: - Utils
    
    func add(_ data: ModelType) {
        self.data = data
        self.lastUpdate = Date()
    }
    
    func clear() {
        self.data = nil
        self.lastUpdate = nil
    }
    
    func setLastUpdate() {
        self.lastUpdate = Date()
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        guard let dataDict = aDecoder.decodeObject(forKey: "data") as? [String: AnyObject] else { return nil }
        self.data = ModelType(dictionary: dataDict)
        self.lastUpdate = aDecoder.decodeObject(forKey: "lastUpdate") as? Date
        self.refreshTimeOut = aDecoder.decodeObject(forKey: "timeOut") as? TimeInterval ?? 300
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(data?.dictionaryRepresentation(), forKey: "data")
        aCoder.encode(lastUpdate, forKey: "lastUpdate")
        aCoder.encode(refreshTimeOut, forKey: "timeOut")
    }

}



