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
    
    // MARK: - Properties

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont.Caption2()
    }
    
    // MARK: - Configure 
    
    func configureWithCastMember(_ member: CastMember) {
        
        nameLabel.text = member.name
        guard let profilePath = member.profilePath, let url = TMDbImageRouter.posterMedium(path: profilePath).url else { return }
        profileImageView.sd_setImage(with: url, placeholderImage: UIImage.placeholderImage())
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
    }
    
}