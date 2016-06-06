//
//  TMDbDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

// MARK: TMDbDataManagerNotification

public enum TMDbDataManagerNotification {
    case DataDidUpdate
    case DataDidChange
    case DidReceiveError
    
    public var name: String {
        switch self {
        case .DataDidUpdate:
            return "TMDbDataManagerDataDidUpdateNotification"
        case .DataDidChange:
            return "TMDbManagerDataDidChangeNotification"
        case .DidReceiveError:
            return "TMDbManagerDidReceiveErrorNotification"
        }
    }
    
}

// MARK: TMDbDataManager

protocol TMDbDataManager: class {
    var inProgress: Bool { get set }
    func postUpdateNotification()
    func postChangeNotification()
    func postErrorNotification(error: NSError)
}

// MARK: - Default Implementation 

extension TMDbDataManager { // Should not be exposed to outside of class 
    
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

