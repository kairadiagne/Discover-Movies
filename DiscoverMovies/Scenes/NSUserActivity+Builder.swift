//
//  Movie+NSUserActivity.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 22/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import TMDbMovieKit

extension NSUserActivity {

    /// Represents the type of the user activities supported in the app.
    enum ActivityType: String {

        /// The user activity related to showing the details of a movie.
        case movieDetail = "com.kairadiagne.discover.openMovieDetail"
    }

    static let MovieDetailTitle = "movieDetailTitleKey"
    static let MovieDetailDataKey = "movie"

    /// Creates a `NSUserActivity` object for the specified movie.
    /// - Parameters:
    ///   - movie: The movie to create the user acvitiy for.
    ///   - selectedTabIndex: The index of the current selected tab in the tab bar controller
    static func detailActivity(for movie: Movie) -> NSUserActivity {
        let userActivity = NSUserActivity(activityType: ActivityType.movieDetail.rawValue)
        userActivity.title = MovieDetailTitle

        do {
            let movieData = try JSONEncoder().encode(movie)
            userActivity.userInfo = [MovieDetailDataKey: movieData]
            return userActivity
        } catch let error {
            print(error)
            return userActivity
        }
    }
}
