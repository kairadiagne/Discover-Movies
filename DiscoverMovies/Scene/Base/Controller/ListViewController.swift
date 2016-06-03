//
//  ListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import BRYXBanner
import MBProgressHUD

class ListViewController: BaseViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: BaseTableView!
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldShowSignInViewController {
            showSignInViewController()
        }
    }
    
}





