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
    
    class func applyTheme() {
        // Default style labels
        UILabel.appearance().backgroundColor = UIColor.clear
        UILabel.appearance().textColor = UIColor.white
        
        // Default navbarstyle
        UINavigationBar.appearance().barTintColor = UIColor.navbarColor()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().isOpaque = false
        
        // Default tableView style
        UITableView.appearance().backgroundColor = UIColor.backgroundColor()
        UITableViewCell.appearance().backgroundColor = UIColor.backgroundColor()
        UITableView.appearance().separatorColor = UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 60.0/255.0)
        
        // Default UICollectionView style
        UICollectionView.appearance().backgroundColor = UIColor.backgroundColor()
    }
    
}
