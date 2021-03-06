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

final class PersonDetailView: BaseView {
    
    // MARK: - Properties
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var infoLabelsStackView: UIStackView!
    @IBOutlet weak var biographyLabelsStackView: UIStackView!
    @IBOutlet weak var moviesStackView: UIStackView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    
    @IBOutlet weak var biographyTitleLabel: UILabel!
    @IBOutlet weak var biograhphyLabel: UILabel!
    
    @IBOutlet weak var disclosureButtonStackView: UIStackView!
    @IBOutlet weak var disclosureButton: UIButton!
    
    @IBOutlet weak var moviesTitleLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var homePageButtonStackView: UIStackView!
    @IBOutlet weak var homepageButton: DiscoverButton!
    
    @IBOutlet weak var unavailableLabel: UILabel!

    @IBOutlet weak var biographyStackViewTop: NSLayoutConstraint!
    @IBOutlet weak var profileImageBottomToMovieStackViewTop: NSLayoutConstraint!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        bornLabel.text = "bornLabeLPreix".localized
        diedLabel.text = "diedLabelPrefix".localized
        biographyTitleLabel.text = "biographyTitleLabel".localized
        moviesTitleLabel.text = "moviesKnowFor".localized
        
        homepageButton.setTitle("homePageButton".localized, for: .normal)
        
        disclosureButton.setImage(UIImage(named: "Expand"), for: .normal)
        disclosureButton.setImage(UIImage(named: "Collapse"), for: .selected)
        disclosureButton.setBackground(color: .clear, forState: .normal)
        disclosureButton.setBackground(color: .clear, forState: .selected)
        disclosureButton.tintColor = .white
        
        backButton.tintColor = .white
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        backButton.setTitle("backButtonTitle".localized, for: .normal)
        
        unavailableLabel.textColor = .white
        unavailableLabel.font = UIFont.Body()
        
        // Hide views until there is data
        infoLabelsStackView.isHidden = true
        biographyLabelsStackView.isHidden = true
        disclosureButtonStackView.isHidden = true
        moviesStackView.isHidden = true
        disclosureButton.isHidden = true
        homepageButton.isHidden = true
        unavailableLabel.isHidden = true
    }
    
    // MARK: - Configure
    
    func configure(personRespresentable: PersonRepresentable) {
        bornLabel.isHidden = true
        diedLabel.isHidden = true
        
        nameLabel.text = personRespresentable.name
        infoLabelsStackView.isHidden = false
        
        unavailableLabel.text = "infoUnavailable".localized
        unavailableLabel.isHidden = false
        
        let path = personRespresentable.profilePath ?? ""
        let imageURL = TMDbImageRouter.posterLarge(path: path).url
        profileImageView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderProfileImage())
    }
    
//    func configure(person: Person) {
//        // Name
//        nameLabel.text = person.name
//        infoLabelsStackView.isHidden = false
//        
//        // Profile Image 
//        let path = person.profilePath ?? ""
//        let imageURL = TMDbImageRouter.posterLarge(path: path).url
//        profileImageView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderProfileImage())
//        profileImageView.isHidden = false
//        
//        // Birth
//        if let birthday = person.birthDay {
//            var birthInfo = birthday
//            
//            if let age = birthday.toDate()?.age {
//                birthInfo = birthInfo + " " + "(" + "\(age)" + ")"
//            }
//            
//            if let birthPlace = person.birthPlace {
//                birthInfo = birthInfo + "\n\(birthPlace)"
//            }
//            
//            bornLabel.text = birthInfo
//            bornLabel.isHidden = false
//        } else {
//            bornLabel.isHidden = true
//        }
//        
//        // DeathDay
//        if let deathDay = person.deathDay {
//            diedLabel.text = deathDay
//            diedLabel.isHidden = false
//            infoLabelsStackView.isHidden = false
//        } else {
//            diedLabel.isHidden = true 
//        }
//        
//        // Biography
//        if let biography = person.biography {
//            biograhphyLabel.text = biography
//            biograhphyLabel.isHidden = false
//            disclosureButton.isHidden = person.biography == nil || biograhphyLabel.currentNumberOfLines < 5
//            disclosureButtonStackView.isHidden = person.biography == nil || biograhphyLabel.currentNumberOfLines < 5
//            biographyLabelsStackView.isHidden = false
//        } else {
//            biographyStackViewTop.priority = UILayoutPriority(rawValue: 250)
//            profileImageBottomToMovieStackViewTop.priority = UILayoutPriority(rawValue: 750)
//        }
//        
//        // Homepage
//        if person.homepage == nil {
//            homepageButton.isHidden = true
//            homePageButtonStackView.isHidden = true
//        }
//    }
   
    // MARK: - Utils
    
    func setBiographyLabel(expanded: Bool, animated: Bool) {
        biograhphyLabel.numberOfLines = expanded ? 0 : 5
        
        if animated {
            UIView.animate(withDuration: 0.5) {
                self.biograhphyLabel.layoutIfNeeded()
            }
        }
    }
}
