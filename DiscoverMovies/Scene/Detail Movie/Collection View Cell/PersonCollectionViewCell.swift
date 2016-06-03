//
//  PersonCollectionViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class PersonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont.Caption2()
    }
    
    // MARK: Configure 
    
    func configureWithCastMember(member: TMDbCastMember) {
        guard let path = member.profilePath else { return }
        nameLabel.text = member.name
        
        if let url = TMDbImageRouter.PosterMedium(path: path).url {
             profileImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
        }
       
    }
    
}
