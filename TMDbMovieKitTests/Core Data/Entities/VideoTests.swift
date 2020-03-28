//
//  VideoTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 29/03/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class VideoTests: BaseTestCase {

    /// When the video gets deleted it should not cascade the delete to the movie it belongs to.
    func testDoesNotCascadeDeleteToMovie() throws {
        let networkMovie = try MockedData.movie.mapToModel(of: TMDBMovie.self)
        let movie = Movie.insert(into: viewContext, movie: networkMovie)
        let video = Video.test(in: viewContext)
        movie.addToTrailers(video)
        
        viewContext.delete(video)
        
        XCTAssertTrue(video.isDeleted)
        XCTAssertFalse(movie.isDeleted)
    }
}
