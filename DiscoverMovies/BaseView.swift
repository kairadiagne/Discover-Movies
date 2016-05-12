//
//  BaseView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import MBProgressHUD
import BRYXBanner
import ChameleonFramework

class BaseView: UIView {
    
    private struct Constants {
        static let HUDSize = CGSize(width: 40, height: 40)
    }
    
    lazy var progressHUD: MBProgressHUD =  {
        let frame = CGRect(origin: .zero, size: Constants.HUDSize)
        let progressHUD = MBProgressHUD(frame: frame)
        progressHUD.color = Theme.BaseColors.ProgressHUDColor
        return progressHUD
    }()
    
    var banner: Banner?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(progressHUD)
        progressHUD.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
        progressHUD.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Progress HUD
    
    func showProgressHUD() {
        progressHUD.show(true)
    }
    
    func dismissProgressHUD() {
        progressHUD.hide(true)
    }
    
    // MARK: - Banner
    
    /** 
     If a view is specified, the banner will be displayed at the top of that view, otherwise
     at the top of the window. When the banenr is not nil it means it is currently being presented on screen
     and it needs to be dismissed before another banner gets displayed. 
    */
    
    func showBanner(title: String, message: String) {
        // If a banner is currently on screen it will be dismissed
        banner?.dismiss()
        
        // Create and show new banner 
        banner = Banner()
        banner?.titleLabel.text = title
        banner?.detailLabel.text = message
        banner?.backgroundColor = UIColor.flatOrangeColor()
        banner?.dismissesOnSwipe
        
        banner?.show()
    }
    
}





