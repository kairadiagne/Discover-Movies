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
    @IBOutlet weak var feedbackButton: DiscoverButton!
    @IBOutlet weak var icon8Button: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.hideEmptyRows()
    
        descriptionLabel.textColor = UIColor.white
        containerView.backgroundColor = UIColor.clear
        
        icon8Button.setTitleColor(UIColor.white, for: .normal)
        tmdbButton.setTitleColor(UIColor.white, for: .normal)
        
        descriptionLabel.font = UIFont.Body()

        descriptionLabel.text = NSLocalizedString("description", comment: "")
        icon8Button.setTitle(NSLocalizedString("icon8Acknowledgmenet", comment: ""), for: .normal)
        tmdbButton.setTitle(NSLocalizedString("tmdbacknowledgement", comment: ""), for: .normal)
        feedbackButton.setTitle(NSLocalizedString("feedbackButtonTitle", comment: ""), for: .normal)
    }

}
