//
//  CachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

class CachedData<ModelType: DictionarySerializable>: NSObject, NSCoding {
    
    // MARK: - Properties
    
    var data: ModelType? {
        didSet {
            if data == nil {
                lastUpdate = nil
            } else {
                lastUpdate = Date()
            }
        }
    }
    
    var needsRefresh: Bool {
        guard let lastUpdate = lastUpdate else { return true }
        return Date().timeIntervalSince(lastUpdate) > refreshTimeOut
    }
    
    let refreshTimeOut: TimeInterval
    
    private(set) var lastUpdate: Date?
    
    // MARK: - Initialize
    
    required init(refreshTimeOut timeOut: TimeInterval) {
        refreshTimeOut = timeOut
        super.init()
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
