//
//  InternetErrorHandleable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import ChameleonFramework

// MARK: - Protocol InternetErrorHandleable

protocol InternetErrorHandleable {
    func detectInternetConnectionError(error: NSError)
    func handleInternetConnectionError()
}

// MARK: - Default Implementation InternetErrorHandleable

extension InternetErrorHandleable where Self: BannerPresentable {
    
    func detectInternetConnectionError(error: NSError) {
        if error.code == NSURLErrorNotConnectedToInternet {
            handleInternetConnectionError()
        }
    }
    
    func handleInternetConnectionError() {
        // TODO: - Start Using NSLocalizedString
        let title = "No, Internet Connection"
        let message = "Couldn't load any information, please check your connection and try again later"
        showBanner(title, message: message, color: UIColor.flatOrangeColor())
    }
    
}

