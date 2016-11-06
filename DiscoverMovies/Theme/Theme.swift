//
//  Theme.swift
//  Discover
//
//  Created by Kaira Diagne on 04-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import ChameleonFramework
import youtube_ios_player_helper

class Theme {
    
    // MARK: - Apply Theme
    
    class func apply() {
        styleNavigationBar()
        styleTableView()
        styleCollectionView()
    }
    
    class func styleNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.navbarColor()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().isOpaque = false
    }
    
    class func styleTableView() {
        UITableView.appearance().backgroundColor = UIColor.backgroundColor()
        UITableViewCell.appearance().backgroundColor = UIColor.backgroundColor()
        UITableView.appearance().separatorColor = UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 60.0/255.0)
    }
    
    class func styleCollectionView() {
        UICollectionView.appearance().backgroundColor = UIColor.backgroundColor()
    }
    
}
