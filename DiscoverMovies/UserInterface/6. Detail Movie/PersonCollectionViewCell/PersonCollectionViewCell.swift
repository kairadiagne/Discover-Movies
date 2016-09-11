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
    
    // MARK: Properties

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont.Caption2()
    }
    
    // MARK: Configure 
    
    func configureWithCastMember(_ member: CastMember) {
        nameLabel.text = member.name
        let profilePath = member.profilePath ?? ""
        let url = TMDbImageRouter.PosterMedium(path: profilePath).url ?? URL()
        profileImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
    }
    
}
