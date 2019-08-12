//
//  ReviewTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

final class ReviewTableViewCell: UITableViewCell, NibReusabelCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        authorLabel.font = UIFont.H2()
        authorLabel.textColor = .buttonColor()
    
        contentLabel.font = UIFont.Body()
        contentLabel.textColor = .white
    }
    
    // MARK: - Awake
    
    func configure(_ review: Review) {
        
        authorLabel?.text = "authorLabelPrefixText".localized + " \(review.author)"
        contentLabel?.text = review.content
    }
}
