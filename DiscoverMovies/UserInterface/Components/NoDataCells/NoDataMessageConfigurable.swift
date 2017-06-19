//
//  NoDataMessageConfigurable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

protocol NoDataMessageConfigurable {
    var messageLabel: UILabel! { get set }
    func configure(with message: String)
}

extension NoDataMessageConfigurable {
    
    func configure(with message: String) {
        messageLabel.text = message
    }
    
}
