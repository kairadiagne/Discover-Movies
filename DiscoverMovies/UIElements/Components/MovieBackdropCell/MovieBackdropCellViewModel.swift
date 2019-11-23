//
//  MovieBackdropCellViewModel.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23/11/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import TMDbMovieKit

struct MovieBackDropCellViewModel {

    // MARK: Properties

    var title: String {
        return movie.title
    }

    var subtitle: String {
        guard let releaseDate = movie.releaseDate.toDate()?.year() else {
            return "cellUnknownYearText".localized
        }

        return String(releaseDate)
    }

    var imageURL: URL? {
        return TMDbImageRouter.backDropMedium(path: movie.backDropPath).url
    }

    private let movie: Movie

    // MARK: Iniialize

    init(movie: Movie) {
        self.movie = movie
    }
}
