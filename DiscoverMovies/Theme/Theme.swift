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
    
    // MARK: - Constants

    struct BaseColors {
        static let BackgroundColor = UIColor(red: 30.0/255, green: 30.0/255, blue: 30.0/255, alpha: 1.0) // #634d36
        static let LabelBackgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        static let NavbarColor = UIColor(red: 27.0/255, green: 27.0/255, blue: 27.0/255, alpha: 1.0)
        static let ProgressHUDColor =  UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 0.8)
    }
    
    // MARK: - Apply theme
    
    class func applyGlobalTheme() {
        styleViews()
        styleNavBar()
        styleTabBar()
        styleTableViews()
        styleTextFields()
        styleLabels()
    }
    
    // MARK: - Class Funcs
    
    class func styleViews() {
        UIScrollView.appearance().backgroundColor = BaseColors.BackgroundColor
        DetailView.appearance().backgroundColor = BaseColors.BackgroundColor
        BackgroundView.appearance().backgroundColor = BaseColors.BackgroundColor
        YTPlayerView.appearance().backgroundColor = BaseColors.BackgroundColor
        
    }
    
    class func styleTabBar() {
        UITabBar.appearance().barTintColor = BaseColors.NavbarColor
        UITabBar.appearance().opaque = false
        UITabBar.appearance().translucent = false
        UITabBar.appearance().tintColor = UIColor.whiteColor()
    }
    
    class func styleNavBar() {
        UINavigationBar.appearance().barTintColor = BaseColors.NavbarColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().opaque = false
    }
    
    class func styleTableViews() {
        UITableView.appearance().backgroundColor = BaseColors.BackgroundColor
        UITableViewCell.appearance().backgroundColor = BaseColors.BackgroundColor
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
    
    class func others() { // Change name when Refractoring this class
        
    }
    
    // HEX converter 

}
