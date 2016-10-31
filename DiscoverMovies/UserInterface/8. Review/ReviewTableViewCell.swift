//
//  ReviewTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorLabel.font = UIFont.H2()
        contentLabel.font = UIFont.Body()
    }
    
    // MARK: - Awake
    
    func configure(_ review: Review) {
        
        authorLabel?.text = NSLocalizedString("authorLabelPrefixText", comment: "") + " \(review.author)"
        contentLabel?.text = review.content
    }
    
}