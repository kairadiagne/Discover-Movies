//
//  AccountListdataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/06/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class AccountListDataSource: BaseTableViewDataSource<Movie, AccountListTableViewCell> {
    
    override init(emptyMessage: String = "noMoviesInListText".localized) {
        super.init(emptyMessage: emptyMessage)
    }
    
    override func configure(_ cell: AccountListTableViewCell, atIndexPath indexPath: IndexPath) {
        let movie = items[indexPath.row]
        let imageURL = TMDbImageRouter.posterSmall(path: movie.posterPath).url
        cell.configure(movie, imageURL: imageURL)
    }
}
