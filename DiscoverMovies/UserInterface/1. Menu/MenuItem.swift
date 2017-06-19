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
            return "topListMenuItemText".localized
        case .watchlist:
            return "watchListMenuItemText".localized
        case .favorites:
            return "favoritesMenuItemText".localized
        case .search:
            return "searchMenuItemText".localized
        case .signin:
            return signedIn ? "signOutMenuItemText".localized : "signInMenuItemText".localized
        case .about:
            return "aboutmenuItemText".localized
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
