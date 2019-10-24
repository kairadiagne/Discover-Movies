//
//  MovieDetailViewModel.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import TMDbMovieKit

final class MovieDetailViewModel {

    enum State {
        /// The view model is idle
        case idle

        // The view model is in the process of loading additional information
        case loading
    }

    // MARK: - Properties

    /// The current state of the view model.
    private(set) var currentState: State = .idle

    /// Whether the view should show the account list controls.
    var shouldshowAccountListControls: Bool {
        return true
//        return sessionManager.status == .signedIn
    }

    /// An movie object containing the information needed to fetch additonal info to display.
    private let movie: MovieRepresentable

    /// The detail managed used to fetch addtional data.
//    private var detailManager: MovieDetailManager // Protocol

    /// The session manager used to retrieve the status of the current user of the app.
//    private var sessionManager: UserSesssionManager

    // MARK: - Initialize

    init(movie: Movie) {
        self.movie = movie
        // Fetch aditional details on the movie
    }

    init(movie: MovieRepresentable) {
        self.movie = movie
        // Fetch aditional details on the movie
    }

    func fetchAddtionalInfo() {
//        detailManager.reloadIfNeded()
    }
}
