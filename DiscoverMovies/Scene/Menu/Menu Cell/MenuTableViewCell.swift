//
//  MenuTableViewCell.swift
//  
//
//  Created by Kaira Diagne on 16/05/16.
//
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuImage: UIButton!
    @IBOutlet weak var menuLabel: UILabel!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        self.menuLabel.font = UIFont.H3()
        self.menuImage.tintColor = UIColor.whiteColor()
    }
    
    // MARK: - Configure
    
    func configureWithItem(text: String, imageName name: String) {
        self.menuLabel.text = text
        let image = UIImage(named: name)
        self.menuImage.setBackgroundImage(image, forState: .Normal)
    }
    
}
