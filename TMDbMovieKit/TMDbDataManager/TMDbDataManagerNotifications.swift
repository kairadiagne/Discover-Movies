//
//  TMDbDataManagerNotifications.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

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


