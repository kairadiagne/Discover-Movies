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
    
    class func applyGlobalTheme() {
        styleNavBar()
        styleViews()
        styleTableViews()
        styleCollectionViews()
        styleTextFields()
        styleLabels()
    }
    
    // MARK: - Style Components
    
    class func styleNavBar() {
        UINavigationBar.appearance().barTintColor = UIColor.navbarColor()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().isOpaque = false
    }
    
    class func styleViews() {
        YTPlayerView.appearance().backgroundColor = UIColor.backgroundColor()
    }
    
    class func styleTableViews() {
        UITableView.appearance().backgroundColor = UIColor.backgroundColor()
        UITableViewCell.appearance().backgroundColor = UIColor.backgroundColor()
        UITableView.appearance().separatorColor = UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 60.0/255.0)
    }
    
    class func styleCollectionViews() {
        UICollectionView.appearance().backgroundColor = UIColor.backgroundColor()
    }
    
    class func styleTextFields() {
        UITextField.appearance().backgroundColor = UIColor.flatGray()
        UITextField.appearance().font = UIFont.Body()
    }
    
    class func styleLabels() {
        UILabel.appearance().textColor = UIColor.white
        UILabel.appearance().backgroundColor = UIColor.clear
    }
    
}
