//
//  AboutView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 30-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class AboutView: BaseView {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tmdbLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feedbackButton: UIButton!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.hideEmptyRows()
        
        titleLabel.textColor = UIColor.white
        descriptionLabel.textColor = UIColor.white
        tmdbLabel.textColor = UIColor.white
        
        titleLabel.font = UIFont.H1()
        descriptionLabel.font = UIFont.Body()
        tmdbLabel.font = UIFont.Caption()
        
        descriptionLabel.text = NSLocalizedString("description", comment: "")
        tmdbLabel.text = NSLocalizedString("tmdbacknowledgement", comment: "")
        feedbackButton.setTitle(NSLocalizedString("feedbackButtonTitle", comment: ""), for: .normal)
    }

}
