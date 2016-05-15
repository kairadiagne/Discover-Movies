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
    
    // MARK: - Apply Seperate
    
    class func styleNavBar() {
        UINavigationBar.appearance().barTintColor = UIColor.navbarColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().opaque = false
    }
    
    class func styleViews() {
        UIScrollView.appearance().backgroundColor = UIColor.backgroundColor()
        DetailView.appearance().backgroundColor = UIColor.backgroundColor()
        BackgroundView.appearance().backgroundColor = UIColor.backgroundColor()
        YTPlayerView.appearance().backgroundColor = UIColor.backgroundColor()
        
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

// MARK: - Fontstack

extension UIFont {
    
    static func H1() -> UIFont? {
        return UIFont(name: "Avenir-Heavy", size: 22.0)
    }
    
    static func H2() -> UIFont? {
        return UIFont(name: "Avenir-Medium", size: 18.0)
    }
    
    static func H3() -> UIFont? {
        return UIFont(name: "Avenir-Medium", size: 16.0)
    }
    
    static func Body() -> UIFont? {
        return UIFont(name: "Avenir-Book", size: 15.0)
    }

    static func Caption() -> UIFont? {
        return UIFont(name: "Avenir-Book", size: 14.0)
    }
    
    static func Caption2() -> UIFont? {
        return UIFont(name: "Avenir-Book", size: 8)
    }
    
}

// MARK: - Colors

extension UIColor {
    
    static func backgroundColor() -> UIColor {
        return UIColor(red: 41.0/255, green: 47.0/255, blue: 51.0/255, alpha: 1.0)
    }
    
    static func labelColor() -> UIColor {
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    }
    
    static func navbarColor() -> UIColor {
        return UIColor(red: 46.0/255, green: 52.0/255, blue: 56.0/255, alpha: 1.0)
    }
    
    static func progressHUDColor() -> UIColor {
        return UIColor(red: 46/255, green: 52/255, blue: 56/255, alpha: 0.8)
    }
    
}







