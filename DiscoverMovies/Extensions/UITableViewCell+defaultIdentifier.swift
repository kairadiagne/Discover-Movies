//
//  UITableViewCell+defaultIdentifier.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 04-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    public class func defaultIdentifier() -> String {
        return String(self)
    }
    
    public class func nibName() -> String {
        return String(self)
    }
    
}

