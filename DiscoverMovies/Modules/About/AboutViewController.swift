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

final class AboutViewController: BaseViewController {
    
    // MARK: - Types
    
    private struct Constants {
        static let SectionCellIdentifier = "SectionCellIdentifier"
    }
    
    private enum Acknowledgement: Int, Section {
        case themoviedb
        case icons8
        case acknowledgements
        
        var rowTitle: String {
            switch self {
            case .themoviedb:
                return "aboutTheMoviedb".localized
            case .icons8:
                return "aboutIcons8".localized
            case .acknowledgements:
                return "aboutAcknowledgements".localized
            }
        }
    }
    
    private enum Feedback: Int, Section {
        case contact
        case rate
        
        var rowTitle: String {
            switch self {
            case .contact:
                return "aboutContact".localized
            case .rate:
                return "aboutRate".localized
            }
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet var aboutView: AboutView!
    
    private var safariViewController: SFSafariViewController?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.SectionCellIdentifier)
        
        aboutView.tableView.delegate = self
        aboutView.tableView.dataSource = self
        title = "aboutTitle".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Helpers
    
    func row(for indexPath: IndexPath) -> Section? {
        var section: Section?
        
        if indexPath.section == 0 {
            section = Acknowledgement(rawValue: indexPath.row)
        } else {
            section = Feedback(rawValue: indexPath.row)
        }
        
        return section
    }
    
    // MARK: - Navigation
    
    private func openInSafari(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        safariViewController = SFSafariViewController(url: url)
        present(safariViewController!, animated: true, completion: nil)
    }
    
    private func showAcknowledgements() {
        let acknowledgementsViewController = AcknowledgementsTableViewController()
        navigationController?.pushViewController(acknowledgementsViewController, animated: true)
    }
    
    private func openMail() {
        guard let url = URL(string: "mailto:discover.movies.app@gmail.com") else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }

}

// MARK: - UITableViewDelegate

extension AboutViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "acknowledgementSectionTitle".localized : "feedbackSectionTitle".localized
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 1 ? "aboutFooterText".localized : nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView  = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.font = UIFont.H3()
        headerView.textLabel?.textColor = .buttonColor()
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footerView = view as? UITableViewHeaderFooterView else { return }
        footerView.textLabel?.font = UIFont.Caption()
        footerView.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = row(for: indexPath) else { return }
        
        if row is Acknowledgement {
            // swiftlint:disable force_cast
            switch row as! Acknowledgement {
            case .themoviedb:
                openInSafari(urlString: "https://www.themoviedb.org")
            case .icons8:
                openInSafari(urlString: "https://icons8.com")
            case .acknowledgements:
                showAcknowledgements()
            }
        } else if row is Feedback {
            // swiftlint:disable force_cast
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SectionCellIdentifier, for: indexPath)
        guard let row = row(for: indexPath) else { return cell }
        cell.textLabel?.text = row.rowTitle
        cell.textLabel?.textColor = .white
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
