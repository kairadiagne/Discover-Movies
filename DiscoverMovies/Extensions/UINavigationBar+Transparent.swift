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
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
        isTranslucent = true
    }
    
    func setAsUnclear() {
        isTranslucent = false
    }
}
