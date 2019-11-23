//
//  DiscoverListCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

final class DiscoverListCell: UITableViewCell, NibReusable {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.H1()
        titleLabel.textColor = .white
        
        yearLabel.font = UIFont.H3()
        yearLabel.textColor = .white
        
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        titleLabel.layer.shadowOpacity = 0.5
        titleLabel.layer.shadowRadius = 1
        
        yearLabel.layer.shadowColor = UIColor.black.cgColor
        yearLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        yearLabel.layer.shadowOpacity = 0.5
        yearLabel.layer.shadowRadius = 1
    }
    
    // MARK: - Configure
    
    func configure(_ movie: Movie, imageURL: URL?) {
        titleLabel.text = movie.title
        
        if let releaseYear = movie.releaseDate.toDate()?.year() {
            yearLabel.text = "\(releaseYear)"
        } else {
            yearLabel.text = "cellUnknownYearText".localized
        }
        
        movieImageView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieImageView.image = nil 
    }
}
