//
//  InternetErrorHandlerProtocol.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import BRYXBanner

protocol InternetErrorHandlerProtocol: class {
    var banner: Banner? { get set }
    func detectInternetConnectionError(error: NSError)
}

extension InternetErrorHandlerProtocol {
    
    func detectInternetConnectionError(error: NSError) {
        if error.code == NSURLErrorNotConnectedToInternet {
            if let existingBanner = self.banner { existingBanner.dismiss() }
            let title = "No Internet Connection"
            let subtitle = "Couldn't load any information, please check your connection and try again later"
            banner = Banner(title: title, subtitle: subtitle ,image: nil, backgroundColor: UIColor.flatOrangeColor())
            banner?.dismissesOnSwipe = true
            banner?.show()
        }
    }
    
}
