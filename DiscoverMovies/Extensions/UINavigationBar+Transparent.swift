//
//  UINavigationBar+Transparent.swift
//  Discover
//
//  Created by Kaira Diagne on 04-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func setAsTransparent() {
        setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        shadowImage = UIImage()
        translucent = true
    }
    
    func setAsUnclear() {
        translucent = false
    }
}
