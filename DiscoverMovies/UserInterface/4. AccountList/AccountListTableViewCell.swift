//
//  AccountListTableViewCell.swift
//  
//
//  Created by Kaira Diagne on 15/06/16.
//
//

import UIKit
import TMDbMovieKit

class AccountListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    // MARK: - Awake From Nib

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.Body()
        titleLabel.textColor = UIColor.white
        
        overViewLabel.font = UIFont.Caption2()
        overViewLabel.textColor = UIColor.white
    }
    
    // MARK: - Configure
    
    func configure(_ movie: Movie, imageURL: URL?) {
        titleLabel.text = movie.title
        overViewLabel.text = movie.overview
        // posterView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage()) // TODO: - Add new placeholder
        posterView.sd_setImage(with: imageURL)
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterView.image = nil
    }
    
}
