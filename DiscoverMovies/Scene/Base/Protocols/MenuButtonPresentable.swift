//
//  MenuButtonPresentable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import SWRevealViewController

// MARK: Protocol MenuButtonPresentable

protocol MenuButtonPresentable {
    func addMenuButton()
}

// MARK: Default Implementation MenuButtonPresentable

extension MenuButtonPresentable where Self: UIViewController {
    
    func addMenuButton() {
        guard let revealViewController = self.revealViewController() else { return }
        view.addGestureRecognizer(revealViewController.panGestureRecognizer())
        
        let menuButton = UIBarButtonItem()
        menuButton.image = UIImage.menuIcon()
        menuButton.target = revealViewController
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationItem.leftBarButtonItem = menuButton
    }
    
}