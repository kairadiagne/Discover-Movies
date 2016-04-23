//
//  UIImage+Placeholder.swift
//  Discover
//
//  Created by Kaira Diagne on 10-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func placeholderImage() -> UIImage {
        return UIImage(named: "PlaceholderImage") ?? UIImage()
    }
    
    static func placeholderProfileImage() -> UIImage {
        return UIImage(named: "ProfileImagePlaceholder") ?? UIImage()
    }
    
}
