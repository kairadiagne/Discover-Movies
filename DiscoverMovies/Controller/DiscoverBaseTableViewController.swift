//
//  DiscoverBaseTableViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 18-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SWRevealViewController
import MBProgressHUD
import ChameleonFramework
import BRYXBanner

class DiscoverBaseTableViewController: UITableViewController, ItemCoordinatorDelegate, InternetErrorHandlerProtocol {
    
    var banner: Banner?
    var progressHUD: MBProgressHUD?
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        configureProgressHUD()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsTransparent()
    }
    
    // MARK: - ItemCoordinatorDelegate
    
    func coordinatorDidUpdateItems(page: Int?) {
        hideProgressHUD()
        tableView.reloadData()
        
        switch page {
        case let x where x == nil || x == 0:
            tableView.backgroundView?.hidden = false
        case let x where x == 1:
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: false)
        case let x where x > 1:
            return
        default:
            fatalError()
        }
    }

}

extension DiscoverBaseTableViewController: ProgressHudShowable {
    
    func coorDinatorDidUpdateWithItemsNextPage() {
        hideProgressHUD()
        tableView.reloadData()
    }
    
    func coordinatorDidReceiveError(error: NSError) {
        hideProgressHUD()
        detectInternetConnectionError(error)
    }
    
}

