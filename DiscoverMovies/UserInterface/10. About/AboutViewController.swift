//
//  AboutViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import MessageUI
import BRYXBanner

class AboutViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet var aboutView: AboutView!
    
    fileprivate var acknowledgements: [Acknowledgement] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMenuButton()
        
        aboutView.tableView.delegate = self
        aboutView.tableView.dataSource = self
        
        let aboutCellNib = UINib(nibName: AboutTableViewCell.nibName(), bundle: nil)
        aboutView.tableView.register(aboutCellNib, forCellReuseIdentifier: AboutTableViewCell.defaultIdentifier())
        
        loadAcknowledgements()
        
        title = NSLocalizedString("aboutTitle", comment: "")
    }
    
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
    
    // MARK: - Actions 

    @IBAction func tmdbButtonClick(_ sender: UIButton) {
        let urlString = "https://www.themoviedb.org"
        
        if let url = URL(string: urlString) {
            UIApplication.shared.openURL(url)
        } else {
            print("Could not open themoviedb.org")
        }
    }
    
    @IBAction func feedbackButtonClick(_ sender: DiscoverButton) {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
            
        composeVC.setToRecipients(["diagekaira@yahoo.com"]) // TODO: - Change email address
        composeVC.setSubject("Hello!")
            
        present(composeVC, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDelegate

extension AboutViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("acknowledgementsTitle", comment: "")
    }
    
    // TODO: - Change appearance of header

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

// MARK: - MFMailComposDelegate

extension AboutViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .saved, .sent:
            let message = NSLocalizedString("thanks", comment: "")
            let banner = Banner(title: "", subtitle: message,  backgroundColor: UIColor.flatGray())
            banner.show(duration: 3.0)
        default:
            return
        }
        
        dismiss(animated: true, completion: nil)
    }
}


