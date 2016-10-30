//
//  AboutViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class AboutViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var aboutView: AboutView!
    
    fileprivate var acknowledgements: [Acknowledgement] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutView.tableView.delegate = self
        aboutView.tableView.dataSource = self
        
        let aboutCellNib = UINib(nibName: AboutTableViewCell.nibName(), bundle: nil)
        aboutView.tableView.register(aboutCellNib, forCellReuseIdentifier: AboutTableViewCell.defaultIdentifier())
    }
    
    func loadAcknowledgements() {
        if let path = Bundle.main.path(forResource: "Acknowledgements", ofType: "plist"),
        let dicts = NSDictionary(contentsOfFile: path)?["PreferenceSpecifiers"] as? [[String: AnyObject]] {
            acknowledgements = dicts.map { return Acknowledgement(dictionary: $0) }.flatMap { $0 }
        }
    }

}

extension AboutViewController: UITableViewDelegate {
    
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("acknowledgementsTitle", comment: "")
    }
    
}

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

struct Acknowledgement: DictionarySerializable {
    
    // MARK: - Properties
    
    let title: String
    var license: String?
    let footer: String
    
    // MARK: - Initialize
    
    
    init?(dictionary dict: [String: AnyObject]) {
        guard let title = dict["Title"] as? String, let footer = dict["FooterText"] as? String else {
            return nil
        }
        
        self.title = title
        self.license = dict["License"] as? String
        self.footer = footer
    }
    
    func dictionaryRepresentation() -> [String: AnyObject] {
        return [:]
    }
    
}
