//
//  SearchTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SearchTableViewCell: UITableViewCell, NibReusabelCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.Body()
        titleLabel.textColor = .white
        
        accessoryType = .disclosureIndicator
    }
    
    // MARK: - Configure
    
    func configure(withMovie movie: Movie, imageURL: URL?) {
        titleLabel.text = movie.title
        movieImageView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
    }
}
