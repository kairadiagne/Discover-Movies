//
//  CastMemberTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 28/03/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class CastMemberTests: BaseTestCase {
    
    /// When the cast member gets deleted it should not cascade the delete to the movies it belongs to.
    func doesNotCascadeDeleteToMovies() throws {
        let networkMovie = try MockedData.movie.mapToModel(of: TMDBMovie.self)
        let movie = Movie.insert(into: viewContext, movie: networkMovie)
        let castMember = CastMember.test(in: viewContext)
        movie.addToCast(castMember)
        
        viewContext.delete(movie)
        try viewContext.save()
        
        XCTAssertNil(castMember.managedObjectContext)
        XCTAssertNotNil(movie.managedObjectContext)
    }
}
