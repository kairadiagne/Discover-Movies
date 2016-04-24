//
//  ReviewTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorLabel?.font = nil
        authorLabel?.font = UIFont.H2()
        reviewLabel?.font = UIFont.Body()
    }

}

// MARK: - Configure Methods

extension ReviewTableViewCell {
    
    func configure(review: TMDbReview) {
        authorLabel?.text = review.author != nil ? "A movie review by \(review.author!)" : "A movie review by ..."
        reviewLabel?.text = review.content != nil  ? review.content! : ""
    }
    
}
