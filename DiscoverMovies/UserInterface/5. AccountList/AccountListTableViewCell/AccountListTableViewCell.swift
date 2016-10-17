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
    
    // MARK: Properties
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    // MARK: Awake From Nib

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.font = UIFont.Body()
        self.overViewLabel.font = UIFont.Caption2()
    }
    
    // MARK: Configur
    
    func configure(_ movie: Movie, imageURL: URL?) {
        titleLabel.text = movie.title
        overViewLabel.text = movie.overview
        posterView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterView.image = nil
    }
    
}
