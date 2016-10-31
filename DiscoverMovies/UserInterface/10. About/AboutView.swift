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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tmdbButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feedbackButton: UIButton!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.hideEmptyRows()
    
        descriptionLabel.textColor = UIColor.white
        
        tmdbButton.setTitleColor(UIColor.white, for: .normal)
        
        descriptionLabel.font = UIFont.Body()

        descriptionLabel.text = NSLocalizedString("description", comment: "")
        tmdbButton.setTitle(NSLocalizedString("tmdbacknowledgement", comment: ""), for: .normal)
        feedbackButton.setTitle(NSLocalizedString("feedbackButtonTitle", comment: ""), for: .normal)
    }

}
