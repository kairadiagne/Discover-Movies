//
//  Theme.swift
//  Discover
//
//  Created by Kaira Diagne on 04-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import ChameleonFramework
import MBProgressHUD
import youtube_ios_player_helper

class Theme {
    
    // MARK: - Apply Theme
    
    class func applyGlobalTheme() {
        styleNavBar()
        styleViews()
        styleTabBar()
        styleTableViews()
        styleTextFields()
        styleLabels()
    }
    
    // MARK: - Style Components
    
    class func styleNavBar() {
        UINavigationBar.appearance().barTintColor = UIColor.navbarColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().opaque = false
    }
    
    class func styleViews() {
        UIScrollView.appearance().backgroundColor = UIColor.backgroundColor()
        BackgroundView.appearance().backgroundColor = UIColor.backgroundColor()
        YTPlayerView.appearance().backgroundColor = UIColor.backgroundColor()
        UIStackView.appearance().backgroundColor = UIColor.backgroundColor()
    }
    
    class func styleTabBar() {
        UITabBar.appearance().barTintColor = UIColor.navbarColor()
        UITabBar.appearance().opaque = false
        UITabBar.appearance().translucent = false
        UITabBar.appearance().tintColor = UIColor.whiteColor()
    }
    
    class func styleTableViews() {
        UITableView.appearance().backgroundColor = UIColor.backgroundColor()
        UITableViewCell.appearance().backgroundColor = UIColor.backgroundColor()
        UITableView.appearance().separatorColor = UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 60.0/255.0)
    }
    
    class func styleTextFields() {
        UITextField.appearance().backgroundColor = UIColor.flatGrayColor()
        UITextField.appearance().font = UIFont.Body()
    }
    
    class func styleLabels() {
        UILabel.appearance().textColor = UIColor.whiteColor()
        UILabel.appearance().backgroundColor = UIColor.clearColor()
    }
    
}








