//
//  PersonDetailView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class PersonDetailView: UIView {
    
    // MARK: - Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var infoLabelsStackView: UIStackView!
    @IBOutlet weak var biographyLabelsStackView: UIStackView!
    @IBOutlet weak var moviesStackView: UIStackView!
    
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    
    @IBOutlet weak var biographyTitleLabel: UILabel!
    @IBOutlet weak var biograhphyLabel: UILabel!
    
    @IBOutlet weak var moviesTitleLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var homepageButton: DiscoverButton!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
        scrollView.backgroundColor = UIColor.backgroundColor()
        contentView.backgroundColor = UIColor.backgroundColor()
        
        nameLabel.font = UIFont.H2()
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        
        bornLabel.font = UIFont.Body()
        bornLabel.textColor = .white
        bornLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        
        diedLabel.font = UIFont.Body()
        diedLabel.textColor = .white
        diedLabel.numberOfLines = 0
        diedLabel.lineBreakMode = .byWordWrapping
        
        biographyTitleLabel.font = UIFont.H2()
        biographyTitleLabel.textColor = .white
        
        biograhphyLabel.font = UIFont.Body()
        biograhphyLabel.textColor = .white
        biograhphyLabel.numberOfLines = 0
        biograhphyLabel.lineBreakMode = .byWordWrapping
        
        moviesTitleLabel.font = UIFont.H2()
        moviesTitleLabel.textColor = .white
        
        bornLabel.text = NSLocalizedString("bornLabeLPreix", comment: "")
        diedLabel.text = NSLocalizedString("diedLabelPrefix", comment: "")
        biographyTitleLabel.text = NSLocalizedString("biographyTitleLabel", comment: "")
        moviesTitleLabel.text = NSLocalizedString("moviesKnowFor", comment: "")
        
        homepageButton.setTitle(NSLocalizedString("homePageButton", comment: ""), for: .normal)
    }
    
    // MARK: - Configure
    
    func configure(with person: Person) {
        if let imageURL = TMDbImageRouter.posterLarge(path: person.profilePath).url {
            profileImageView.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderProfileImage())
        } else {
            profileImageView.imageView.image = UIImage.placeholderProfileImage()
        }
        
        nameLabel.text = person.name
        
        let bornText = "\(person.birthDay) "
      
        // Add age
        if let age = person.birthDay.toDate()?.age {
            bornLabel.text = bornText + "\(((age)))" + "\n\(person.birthPlace)"
        } else {
            bornLabel.text = bornText + "\n\(person.birthPlace)"
        }
        
        // If died show death date
        if let deathDay = person.deathDay {
            diedLabel.text = deathDay
        } else {
            diedLabel.isHighlighted = true
        }
        
        biograhphyLabel.text = person.biography
    }

}
