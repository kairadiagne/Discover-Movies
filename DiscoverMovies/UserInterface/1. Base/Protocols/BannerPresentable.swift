//
//  BannerPresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

// MARK: - Protocol BannerPresentable

protocol BannerPresentable: class {
    //    var banner: Banner? { get set }
    //    func showBanner(title: String, message: String, color: UIColor)
}

// MARK: - Default Implementation BannerPresentable 

extension BannerPresentable where Self: UIViewController {
    
    // If a view is specified, the banner will be displayed at the top of that view, otherwise
    // at the top of the window. When the banenr is not nil it means it is currently being presented on screen
    // and it needs to be dismissed before another banner gets displayed.
    
    func showBanner(title: String, message: String, color: UIColor) {
    //        // Hide previous banner if there is one
    //        banner?.dismiss()
    //        
    //        // Create and show new banner
    //        banner = Banner()
    //        banner?.titleLabel.text = title
    //        banner?.detailLabel.text = message
    //        banner?.backgroundColor = color
    //        banner?.dismissesOnSwipe
    //        
    //        banner?.show()
    }
}
