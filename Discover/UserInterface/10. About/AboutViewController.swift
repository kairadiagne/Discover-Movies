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
    
    fileprivate var safariViewController: SFSafariViewController?
    
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
    
    @IBAction func tmdbButtonCLick() {
        openURL(urlString: "https://www.themoviedb.org")
    }
    
    @IBAction func icon8ButtonCLick() {
        openURL(urlString: "https://icons8.com/")
    }
    
    func openURL(urlString: String) {
        if let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("Could not open url")
        }
        
    }
    
    @IBAction func feedbackButtonClick(_ sender: DiscoverButton) {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
            
        composeVC.setToRecipients(["diagekaira@yahoo.com"])
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
    
    @nonobjc func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return NSLocalizedString("acknowledgementsTitle", comment: "")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = view as? UITableViewHeaderFooterView
        header?.contentView.backgroundColor = UIColor.backgroundColor()
        header?.textLabel?.tintColor = UIColor.white
        header?.textLabel?.font = UIFont.Body()
        return header
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


