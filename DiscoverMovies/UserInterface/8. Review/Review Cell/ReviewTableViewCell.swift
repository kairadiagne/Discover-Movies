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
    
    // MARK: Properties
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorLabel.font = UIFont.H2()
        contentLabel.font = UIFont.Body()
    }
    
    // MARK: - Configuration 
    
    func configure(review: TMDbReview) {
        authorLabel?.text = review.author != nil ? "A movie review by \(review.author!)" : "A movie review by ..."
        contentLabel?.text = review.content != nil  ? review.content! : ""
    }
    
}
