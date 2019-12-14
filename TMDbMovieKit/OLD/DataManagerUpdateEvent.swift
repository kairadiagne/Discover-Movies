//
//  DataManagerUpdateEvent.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 11/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

/// Defines a set of update events that can be triggered from an instance of `DataManager`.
public enum DataManagerUpdateEvent {

    /// The data manager did start loading new data.
    case didStartLoading

    /// The data manager did update its data.
    case didUpdate

    /// The data manager did fail with an error.
    case didFailWithError(Error)

    public static let dataManagerUpdateNotificationName = Notification.Name(rawValue: "DataManagerUpdateEvent")

    public static let updateNotificationKey = "value"

    var userInfo: [AnyHashable: Any] {
        return [DataManagerUpdateEvent.updateNotificationKey: self]
    }
}
