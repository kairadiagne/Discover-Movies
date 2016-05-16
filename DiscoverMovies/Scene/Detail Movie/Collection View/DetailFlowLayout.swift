//
//  DetailFlowLayout.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class DetailFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.scrollDirection = .Horizontal
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 10
        self.itemSize = CGSize(width: 107, height: 160)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
