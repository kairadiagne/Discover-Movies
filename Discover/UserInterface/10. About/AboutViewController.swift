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

protocol Section {
    var rowTitle: String { get }
}

class AboutViewController: BaseViewController {
    
    // MARK: - Types
    
    fileprivate enum Info: Int, Section {
        case termsOfUse
        case privacyPolicy
        case acknowledgements
        
        var rowTitle: String {
            switch self {
            case .termsOfUse:
                return NSLocalizedString("aboutTermsOfUse", comment: "")
            case .privacyPolicy:
                return NSLocalizedString("aboutPrivacyPolicy", comment: "")
            case .acknowledgements:
                return NSLocalizedString("aboutAcknowledgements", comment: "")
            }
        }
    }
    
    fileprivate enum Feedback: Int, Section {
        case contact
        case rate
        
        var rowTitle: String {
            switch self {
            case .contact:
                return NSLocalizedString("aboutContact", comment: "")
            case .rate:
                return NSLocalizedString("aboutRate", comment: "")
            }
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet var aboutView: AboutView!
    
    private var safariViewController: SFSafariViewController?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMenuButton()
        
        aboutView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.defaultIdentifier())
        
        aboutView.tableView.delegate = self
        aboutView.tableView.dataSource = self
        title = NSLocalizedString("aboutTitle", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Helpers
    
    func row(for indexPath: IndexPath) -> Section? {
        var section: Section?
        
        if indexPath.section == 0 {
            section = Info(rawValue: indexPath.row)
        } else {
            section = Feedback(rawValue: indexPath.row)
        }
        
        return section
    }
    
    // MARK: - Navigation
    
    fileprivate func openInSafari(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        safariViewController = SFSafariViewController(url: url)
        present(safariViewController!, animated: true, completion: nil)
    }
    
    fileprivate func showAcknowledgements() {
        let acknowledgementsViewController = AcknowledgementsTableViewController()
        navigationController?.pushViewController(acknowledgementsViewController, animated: true)
    }
    
    fileprivate func openMail() {
        // TODO: - Change to discovermovies gmail address
        guard let url = URL(string:"mailto:discover.movies.app@gmail.com") else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.openURL(url)
    }

}

// MARK: - UITableViewDelegate

extension AboutViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? NSLocalizedString("aboutSectionTitle", comment: "") : NSLocalizedString("feedbackSectionTitle", comment: "")
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 1 ? NSLocalizedString("aboutFooterText", comment: "") : nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView  = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.font = UIFont.H3()
        headerView.textLabel?.textColor = UIColor.buttonColor()
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footerView = view as? UITableViewHeaderFooterView else { return }
        footerView.textLabel?.font = UIFont.Caption()
        footerView.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = row(for: indexPath) else { return }
        
        if row is Info {
            switch row as! Info {
            case .termsOfUse:
                openInSafari(urlString: "https://www.themoviedb.org/terms-of-use")
            case .privacyPolicy:
                openInSafari(urlString: "https://www.themoviedb.org/privacy-policy")
            case .acknowledgements:
                showAcknowledgements()
            }
        } else if row is Feedback {
            switch row as! Feedback {
            case .contact:
                openMail()
            case .rate:
                return // Unimplemented
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension AboutViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.defaultIdentifier(), for: indexPath)
        guard let row = row(for: indexPath) else { return cell }
        cell.textLabel?.text = row.rowTitle
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.Body()
        return cell
    }

}

// MARK: _ SFSafariViewcController

extension AboutViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
