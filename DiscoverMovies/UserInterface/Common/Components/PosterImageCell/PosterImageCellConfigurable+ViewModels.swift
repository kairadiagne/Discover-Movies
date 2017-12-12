//
//  PosterImageCellConfigurable .swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

protocol PosterImageCellConfigurable {
    var imageURL: URL? { get }
    var text: String? { get }
}

class PersonCellViewModel: PosterImageCellConfigurable {
    
    // MARK: - Properties
    
    private(set) var imageURL: URL?
    
    private(set) var text: String?
    
    // MARK: - Initialize
    
    init(person: PersonRepresentable) {
        self.imageURL = person.profilePath != nil ? TMDbImageRouter.posterMedium(path: person.profilePath!).url : nil
        self.text = person.name
    }
}

class MoviePosterCellViewModel: PosterImageCellConfigurable {
    
    private(set) var imageURL: URL?
    
    private(set) var text: String?
    
    // MARK: - Initialize
    
    init(movie: MovieRepresentable) {
        self.imageURL = TMDbImageRouter.posterMedium(path: movie.posterPath).url
    }
}
