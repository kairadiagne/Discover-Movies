//
//  AcknowledgementsTableViewController.swift
//  Discover
//
//  Created by Kaira Diagne on 30-12-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

final class AcknowledgementsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var acknowledgements: [Acknowledgement] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "aboutAcknowledgements".localized

        tableView.register(nibReusableCell: AcknowledgementCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadAcknowledgements()
    }
    
    // MARK: - Acknowledgements
    
    func loadAcknowledgements() {
        if let path = Bundle.main.path(forResource: "Acknowledgements", ofType: "plist"),
            let dicts = NSDictionary(contentsOfFile: path)?["PreferenceSpecifiers"] as? [[String: AnyObject]] {
            
            for dict in dicts {
                if let acknowledgement = Acknowledgement(dictionary: dict) {
                    acknowledgements.append(acknowledgement)
                }
            }
            
            // Filter out first and last entry related to cocoapods
            _ = acknowledgements.removeFirst()
            _ = acknowledgements.removeLast()
            
            tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acknowledgements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AcknowledgementCell
        let acknowledgement = acknowledgements[indexPath.row]
        cell.configure(with: acknowledgement)
        return cell
    }
 
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
