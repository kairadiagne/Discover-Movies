//
//  AboutViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var aboutView: AboutView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutView.tableView.delegate = self
        aboutView.tableView.dataSource = self
    }

}

extension AboutViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}

extension AboutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
