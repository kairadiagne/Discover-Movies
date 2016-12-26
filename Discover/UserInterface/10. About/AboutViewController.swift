//
//  AboutViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import BRYXBanner
import MessageUI
import SafariServices

class AboutViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet var aboutView: AboutView!
    
    private var safariViewController: SFSafariViewController?
    
    fileprivate var acknowledgements = [Acknowledgement]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMenuButton()
        
        aboutView.tableView.delegate = self
        aboutView.tableView.dataSource = self
        
        let aboutCellNib = UINib(nibName: AboutTableViewCell.nibName(), bundle: nil)
        aboutView.tableView.register(aboutCellNib, forCellReuseIdentifier: AboutTableViewCell.defaultIdentifier())
        
        title = NSLocalizedString("aboutTitle", comment: "")
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
            let _ = acknowledgements.removeFirst()
            let _ = acknowledgements.removeLast()
            
            aboutView.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension AboutViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}

// MARK: - UITableViewDataSource

extension AboutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acknowledgements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableViewCell.defaultIdentifier(), for: indexPath) as! AboutTableViewCell
        let acknowledgement = acknowledgements[indexPath.row]
        cell.configure(with: acknowledgement)
        return cell
    }

}

// MARK: _ SFSafariViewcController

extension AboutViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
}
