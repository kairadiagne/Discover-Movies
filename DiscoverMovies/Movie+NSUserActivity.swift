//
//  Movie+NSUserActivity.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 22/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import TMDbMovieKit

extension Movie {

    static let OpenMovieDetailActivityType = "com.kairadiagne.discover.openMovieDetail"
    static let OpenMovieTitle = "openMovieDetail"
    static let OpenMovieDetailInfoKey = "movie"

    var openMovieDetailUseractivity: NSUserActivity {
        let userActivity = NSUserActivity(activityType: Movie.OpenMovieDetailActivityType)
        userActivity.title = Movie.OpenMovieTitle
        // swiftlint:disable:next force_try
        userActivity.userInfo = [Movie.OpenMovieDetailInfoKey: try! JSONEncoder().encode(self)]
        return userActivity
    }
}
