//
//  UIFont+Styles.swift
//  Discover
//
//  Created by Kaira Diagne on 20-02-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func H1() -> UIFont? {
        return UIFont(name: "Avenir-Heavy", size: 22.0)
    }
    
    static func H2() -> UIFont? {
        return UIFont(name: "Avenir-Heavy", size: 18.0)
    }
    
    static func H3() -> UIFont? {
        return UIFont(name: "Avenir-Medium", size: 16.0)
    }
    
    static func Body() -> UIFont? {
        return UIFont(name: "Avenir-Book", size: 15)
    }
    
    static func Caption1() -> UIFont? {
        return UIFont(name: "Avenir-Book", size: 11.0)
    }
    
    static func Caption2() -> UIFont? {
        return UIFont(name: "Avenir-BookOblique", size: 11)
    }
    
}
