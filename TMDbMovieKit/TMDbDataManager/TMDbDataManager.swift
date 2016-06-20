//
//  TMDbDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

public enum TMDbDataManagerNotification {
    case DataDidChange
    
    public var name: String {
        switch self {
        case .DataDidChange:
            return "TMDbManagerDataDidChangeNotification"
        }
    }
}

public enum TMDbState {
    case NoData
    case Loading
    case DataDidLoad
    case DataDidUpdate
    case Error
}

public enum TMDbError {
    case Authorization
    case Network
    case Unknown
}

public class TMDbBaseDataManager {
    
    // MARK: Properties
    
    public var state: TMDbState = .NoData {
        didSet {
            postChangeNotification()
        }
    }

    public var lastError: TMDbError?
    
    // MARK: Initializers
    
    public init() { }
    
    // MARK: Notifications
    
    func postChangeNotification() {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbDataManagerNotification.DataDidChange.name, object: self)
    }
    
    public func addChangeObserver(observer: AnyObject, selector aSelector: Selector) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(observer, selector: aSelector, name: TMDbDataManagerNotification.DataDidChange.name, object: self)
    }
    
    public func removeObserver(observer: AnyObject) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(observer, name: TMDbDataManagerNotification.DataDidChange.name, object: self)
    }
    
    // MARK: Update List
    
    func updateList<T: Mappable>(list: TMDbList<T>, withData data: TMDbList<T>) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            
            let didUpdate = list.update(data)
            
            if !didUpdate {
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                if data.items.count == 0 {
                    self.state = .NoData
                } else if data.page == 1 {
                    self.state = .DataDidLoad
                } else if data.page > 1 {
                    self.state = .DataDidUpdate
                }
            })

        }
    }
    
    // MARK: Error Handeling
    
    func handleError(error: NSError) {
        if error.code == NSURLErrorNotConnectedToInternet {
            lastError = .Network
        } else if error.domain == NSURLErrorDomain && error.code == NSURLErrorUserAuthenticationRequired {
            lastError = .Authorization
        } else {
            lastError = .Unknown
        }
        
        state = .Error
        
    }

}
