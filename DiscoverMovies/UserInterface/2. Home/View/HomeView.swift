//
//  HomeView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeView: UIView, ProgressHUDPresentable {
    
    // MARK: - Types 
    
    enum State {
        case idle
        case loading
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchListControl: UISegmentedControl!
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
        
        switchListControl.tintColor = UIColor.white
        
        tableView.addSubview(refreshControl)
    }
    
    // MARK: - Lifecycle
    
    func set(state: State) {
        switch state {
        case .idle:
            hideProgressHUD()
        case .loading:
            showProgressHUD()
        }
    }
    
}
