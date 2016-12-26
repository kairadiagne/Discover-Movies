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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tmdbLabel: UILabel!
    @IBOutlet weak var icon8Label: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.hideEmptyRows()
        
        containerView.backgroundColor = UIColor.clear
        labelContainer.backgroundColor = UIColor.clear
        
        descriptionLabel.textColor = UIColor.white
        creditsLabel.textColor = UIColor.buttonColor()
        icon8Label.textColor = UIColor.white
        tmdbLabel.textColor = UIColor.white
        
        creditsLabel.font = UIFont.H2()
        descriptionLabel.font = UIFont.Body()
        tmdbLabel.font = UIFont.Caption2()
        icon8Label.font = UIFont.Caption2()
    
        descriptionLabel.textAlignment = .center
        tmdbLabel.textAlignment = .center
        icon8Label.textAlignment = .center
        tmdbLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    
        descriptionLabel.text = NSLocalizedString("description", comment: "")
        icon8Label.text = NSLocalizedString("icon8Acknowledgmenet", comment: "")
        tmdbLabel.text = NSLocalizedString("tmdbacknowledgement", comment: "")
        creditsLabel.text = NSLocalizedString("acknowledgementsTitle", comment: "")
    }

}
