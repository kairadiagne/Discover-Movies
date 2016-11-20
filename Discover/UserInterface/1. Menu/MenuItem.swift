//
//  MenuItem.swift
//  Discover
//
//  Created by Kaira Diagne on 20-11-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

enum MenuItem: Int {
    case topList
    case watchlist
    case favorites
    case search
    case signin
    case about
    
    func title(signedIn: Bool) -> String {
        switch self {
        case .topList:
            return NSLocalizedString("topListMenuItemText", comment: "")
        case .watchlist:
            return NSLocalizedString("watchListMenuItemText", comment: "")
        case .favorites:
            return NSLocalizedString("favoritesMenuItemText", comment: "")
        case .search:
            return NSLocalizedString("searchMenuItemText", comment: "")
        case .signin:
            return signedIn ? NSLocalizedString("signOutMenuItemText", comment: "") : NSLocalizedString("signInMenuItemText", comment: "")
        case .about:
            return NSLocalizedString("aboutmenuItemText", comment: "")
        }
    }
    
    func icon(signedIn: Bool) -> UIImage? {
        switch self {
        case .topList:
            return UIImage(named: "Discover")
        case .watchlist:
            return UIImage(named: "Watchlist")
        case .favorites:
            return UIImage(named: "Favorite")
        case .search:
            return UIImage(named: "Search")
        case .signin:
            return UIImage(named: "Logout")
        case .about:
            return UIImage(named: "About")
        }
    }
    
    func enable(signedIn: Bool) -> Bool {
        switch self {
        case .watchlist, .favorites:
            return signedIn ? true : false
        default:
            return true
        }
        
    }
    
}
