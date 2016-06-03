//
//  TMDbDataManagerListener.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 01/06/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

// TODO: - Should this class be in TMDbMovieKit?? 

@objc protocol TMDbDataManagerListenerDelegate: class {
    optional func dataManagerDataDidChangeNotification(notification: NSNotification)
    optional func dataManagerDataDidUpdateNotification(notification: NSNotification)
    optional func dataManagerDidReceiveErrorNotification(error: NSError?)
}

class TMDbDataManagerListener<T: AnyObject>: NSObject { // Generic should conform to TMDbDataManager protocol
    
    weak var delegate: TMDbDataManagerListenerDelegate?
    
    private var manager: T
    
    init(delegate: TMDbDataManagerListenerDelegate?, manager: T) {
        self.delegate = delegate
        self.manager = manager
        super.init()
        
        let updateSelector = #selector(TMDbDataManagerListener.didReceiveUpdateNotification(_:))
        let changeSelector = #selector(TMDbDataManagerListener.didReceiveDataDidChangeNotitification(_:))
        let errorSelector = #selector(TMDbDataManagerListener.didReceiveErrorNotification(_:))
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: updateSelector, name: TMDbDataManagerNotification.DataDidUpdate.name, object: manager)
        notificationCenter.addObserver(self, selector: changeSelector, name: TMDbDataManagerNotification.DataDidChange.name, object: manager)
        notificationCenter.addObserver(self, selector: errorSelector, name: TMDbDataManagerNotification.DidReceiveError.name, object: manager)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Notification methods 
    
    func didReceiveDataDidChangeNotitification(notification: NSNotification) {
        delegate?.dataManagerDataDidChangeNotification?(notification)
    }
        
    func didReceiveUpdateNotification(notification: NSNotification) {
        delegate?.dataManagerDataDidUpdateNotification?(notification)
    }
    
    func didReceiveErrorNotification(notification: NSNotification) {
        let error = notification.userInfo?["error"] as? NSError
        delegate?.dataManagerDidReceiveErrorNotification?(error)
    }
    
}