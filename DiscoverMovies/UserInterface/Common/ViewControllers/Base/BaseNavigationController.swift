//
//  BaseNavigationController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 05-02-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - StatusBar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Rotation
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor()
    }
}
