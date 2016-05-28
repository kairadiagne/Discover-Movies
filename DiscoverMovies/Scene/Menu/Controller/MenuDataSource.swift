//
//  MenuDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//
//
//import UIKit
//
//enum MenuItem: Int {
//    case DiscoverMovies
//    case WatchList
//    case Favorites
//    case Signout
//
//    var title: String {
//        switch self {
//        case .DiscoverMovies:
//            return "Discover new movies"
//        case .WatchList:
//            return "Movies I want to watch"
//        case .Favorites:
//            return "My favorite movies"
//        case .Signout:
//            return "Signout"
//        }
//    }
//    
//    var icon: UIImage? {
//        switch self {
//        case .DiscoverMovies:
//            return UIImage(named: "Discover")
//        case .WatchList:
//            return UIImage(named: "Watchlist")
//        case .Favorites:
//            return UIImage(named: "Favorite")
//        case .Signout:
//            return UIImage(named: "Logout")
//        }
//    }
//    
//}
//
//class MenuDataSource: NSObject, UITableViewDataSource {
//    
//    private let menuItems: [MenuItem] = [.DiscoverMovies, .WatchList, .Favorites, .Signout]
//    
//    var identifier: String = ""
//    
//    // MARK: - UITableViewDataSource
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menuItems.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! MenuTableViewCell
//        let menuItem = menuItems[indexPath.row]
//        cell.configureWithMenuItem(menuItem)
//        return cell
//    }
//    
//    func itemForIndex(index: Int) -> MenuItem? {
//        guard index >= 0 || index <= menuItems.count else { return nil }
//        return menuItems[index]
//    }
//    
//}
