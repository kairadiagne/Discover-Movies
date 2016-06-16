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

public class TMDbBaseDataManager {
    
    // MARK: Properties
    
    public var isLoading = false
    
    // MARK: Initializers
    
    public init() { }
    
    // MARK: Notifications
    
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
    
    public func addChangeObserver(observer: AnyObject, selector aSelector: Selector) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(observer, selector: aSelector, name: TMDbDataManagerNotification.DataDidChange.name, object: self)
    }
    
    public func addUpdateObserver(observer: AnyObject, selector aSelector: Selector) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(observer, selector: aSelector, name: TMDbDataManagerNotification.DataDidUpdate.name, object: self)
    }
    
    public func addErrorObserver(observer: AnyObject, selector aSelector: Selector) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(observer, selector: aSelector, name: TMDbDataManagerNotification.DidReceiveError.name, object: self)
    }
    
    public func removeObserver(observer: AnyObject) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(observer, name: TMDbDataManagerNotification.DataDidUpdate.name, object: self)
        notificationCenter.removeObserver(observer, name: TMDbDataManagerNotification.DataDidChange.name, object: self)
        notificationCenter.removeObserver(observer, name: TMDbDataManagerNotification.DidReceiveError.name, object: self)
    }
    
    // MARK: Update List
    
    func updateList<T: Mappable>(list: TMDbList<T>, withData data: TMDbList<T>) {
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
    
   

}




