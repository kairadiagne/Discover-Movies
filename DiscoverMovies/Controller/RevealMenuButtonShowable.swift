//
//  RevealMenuButtonShowable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import SWRevealViewController

protocol RevealMenuButtonShowable {
    func configureMenuButton()
}

extension RevealMenuButtonShowable where Self: UIViewController {
    
    func configureMenuButton() {
        guard let revealVC = self.revealViewController() else { return }
        let menuButton = UIBarButtonItem()
        menuButton.image = UIImage(named: "Menu")
        menuButton.target = revealVC
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationItem.leftBarButtonItem = menuButton
        view.addGestureRecognizer(revealVC.panGestureRecognizer())
    }
    
}