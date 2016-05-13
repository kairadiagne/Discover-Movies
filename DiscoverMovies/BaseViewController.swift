//
//  BaseViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import BRYXBanner
import MBProgressHUD

class BaseViewController: UIViewController, BannerPresentable, ProgressHUDPresentable, InternetErrorHandleable {

    private struct Constants {
        static let HUDSize = CGSize(width: 40, height: 40)
    }
    
    var banner: Banner?
    
    var progressHUD: MBProgressHUD?
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup ProgressHUD
        progressHUD = MBProgressHUD.hudWithSize(Constants.HUDSize, forFrame: view.bounds)
        view.addSubview(progressHUD!)
    }

}
