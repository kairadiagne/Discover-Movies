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

class PersonDetailView: BaseView {
    
    // MARK: - Properties
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var infoLabelsStackView: UIStackView!
    @IBOutlet weak var biographyLabelsStackView: UIStackView!
    @IBOutlet weak var moviesStackView: UIStackView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    
    @IBOutlet weak var biographyTitleLabel: UILabel!
    @IBOutlet weak var biograhphyLabel: UILabel!
    @IBOutlet weak var disclosureButton: UIButton!
    
    @IBOutlet weak var moviesTitleLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var homepageButton: DiscoverButton!
    @IBOutlet weak var backButton: UIButton!

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
        setBiographyLabel(expanded: false, animated: false)
        biograhphyLabel.lineBreakMode = .byTruncatingHead
        
        moviesTitleLabel.font = UIFont.H2()
        moviesTitleLabel.textColor = .white
        
        bornLabel.text = NSLocalizedString("bornLabeLPreix", comment: "")
        diedLabel.text = NSLocalizedString("diedLabelPrefix", comment: "")
        biographyTitleLabel.text = NSLocalizedString("biographyTitleLabel", comment: "")
        moviesTitleLabel.text = NSLocalizedString("moviesKnowFor", comment: "")
        
        homepageButton.setTitle(NSLocalizedString("homePageButton", comment: ""), for: .normal)
        homepageButton.isEnabled = false
        
        disclosureButton.setBackgroundImage(UIImage(named: "Chevron"), for: .normal)
        disclosureButton.tintColor = UIColor.white
        
        backButton.tintColor = .white
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        backButton.setTitle(NSLocalizedString("backButtonTitle", comment: ""), for: .normal)
        
        // Hide views until there is data
        setViewElements(hidden: true)
    }
    
    // MARK: - Configure
    
    func configure(with person: Person) {
        // Name
        nameLabel.text = person.name
        
        // Set image
        let path = person.profilePath ?? ""
        let imageURL = TMDbImageRouter.posterLarge(path: path).url
        profileImageView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
        
        // BirthInfo
        var birthInfo = ""
        if let birthday = person.birthDay {
            birthInfo = birthday
            
            if let age = birthday.toDate()?.age {
                birthInfo = birthInfo + " " + "(" + "\(age)" + ")"
            }
        }
        
        if let birthPlace = person.birthPlace {
            birthInfo = birthInfo + "\n\(birthPlace)"
        }
        
        bornLabel.text = birthInfo
        
        
        // Death?
        if let deathDay = person.deathDay {
            diedLabel.text = deathDay
        } else {
            diedLabel.isHidden = true
        }
        
        // Biography
        biograhphyLabel.text = person.biography ?? NSLocalizedString("biographyUnavailable", comment: "")
        
        // Homepage
        homepageButton.isEnabled = person.homepage != nil
        
        // Unhide everything
        setViewElements(hidden: false)
    }
    
    // MARK: - Utils
    
    func setViewElements(hidden: Bool) {
        profileStackView.isHidden = hidden
        biographyLabelsStackView.isHidden = hidden
        moviesStackView.isHidden = hidden
        homepageButton.isHidden = hidden
        disclosureButton.isHidden = hidden
    }
    
    func setBiographyLabel(expanded: Bool, animated: Bool) {
        biograhphyLabel.numberOfLines = expanded ? 0 : 5
        
        if animated {
            UIView.animate(withDuration: 0.5) {
                self.biograhphyLabel.layoutIfNeeded()
            }
        }
    }

}
