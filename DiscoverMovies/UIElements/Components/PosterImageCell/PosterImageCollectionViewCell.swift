//
//  PosterImageCollectionViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

final class PosterImageCollectionViewCell: UICollectionViewCell, NibReusabelCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel.font = UIFont.Caption2()
        textLabel.textColor = .white
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: PosterImageCellConfigurable) {
        if let text = viewModel.text {
            textLabel.isHidden = false
            textLabel.text = text
        } else {
            textLabel.isHidden = true
        }
        
        if let imageURL = viewModel.imageURL {
            posterImageView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
        } else {
            posterImageView.image = UIImage.placeholderImage()
        }
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
    }
}
