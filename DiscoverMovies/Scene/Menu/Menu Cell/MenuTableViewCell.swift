//
//  MenuTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
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
    
    func configureWithMenuItem(menuItem: MenuItem) {
        menuLabel.text = menuItem.title

        guard let icon = menuItem.icon else { return }
        menuImage.setBackgroundImage(icon, forState: .Normal)
    }
    
}
