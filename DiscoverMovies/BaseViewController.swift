//
//  BaseViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var baseView: BaseView! // Not working 
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        baseView = BaseView(frame: view.bounds)
        view = baseView
    }
    
    // MARK: - Error Handling
    
    func detectInternetConnectionError(error: NSError) {
        if error.code == NSURLErrorNotConnectedToInternet {
            handleInternetConnectionError()
        }
    }
    
    func handleInternetConnectionError() {
        let title = "No Internet Connection"
        let message = "Couldn't load any information, please check your connection and try again later"
        baseView.showBanner(title, message: message)
    }
    
    func detectAuthoirzationError(error: NSError) {
        if error.domain == NSURLErrorDomain && error.code == NSURLErrorUserAuthenticationRequired {
            handleAuthorizationError()
        }
    }
    
    func handleAuthorizationError() { }
    
    // MARK: - Loading && Banner
    
    func startLoading() {
        baseView.showProgressHUD()
    }
    
    func stopLoading() {
        baseView.dismissProgressHUD()
    }
    
    func showBanner(title: String, message: String) {
        baseView.showBanner(title, message: message)
    }
}

