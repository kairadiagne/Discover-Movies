//
//  MovieTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 28/03/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class MovieTests: BaseTestCase {
    
    /// When a movie gets deleted it should not cascade the delete to the list that it belongs to.
    func testDoesNotCascadeDeleteToList() throws {
        let list = List.list(ofType: .favorite, in: viewContext)
        let networkMovie = try MockedData.movie.mapToModel(of: TMDBMovie.self)
        let movie = Movie.insert(into: viewContext, movie: networkMovie)
        _ = MovieListData.insert(into: viewContext, list: list, order: 0, movie: movie)
        
        viewContext.delete(movie)
        
        XCTAssertTrue(movie.isDeleted)
        XCTAssertFalse(list.isDeleted)
    }
    
    /// When a movie gets deleted it should cascade the delete to its trailers.
    func testCascadesDeleteToTrailers() throws {
        let networkMovie = try MockedData.movie.mapToModel(of: TMDBMovie.self)
        let movie = Movie.insert(into: viewContext, movie: networkMovie)
        let trailer = Video(context: viewContext)
        movie.addToTrailers(trailer)
        
        viewContext.delete(movie)
        try viewContext.save()
        
        XCTAssertNil(movie.managedObjectContext)
        XCTAssertNil(trailer.managedObjectContext)
    }

    /// When a movie gets deleted it should cascade the delete to all its cast/crew members that don't belong to another movie.
    func testCascadesDeleteToMembers() throws {
        let networkMovie = try MockedData.movie.mapToModel(of: TMDBMovie.self)
        let movie = Movie.insert(into: viewContext, movie: networkMovie)
        let crewMember = CrewMember.test(in: viewContext)
        let castMember = CastMember.test(in: viewContext)
        movie.addToCrew(crewMember)
        movie.addToCast(castMember)
        
        viewContext.delete(movie)
        try viewContext.save()
        
        XCTAssertNil(movie.managedObjectContext)
        XCTAssertNil(castMember.managedObjectContext)
        XCTAssertNil(crewMember.managedObjectContext)
    }
    
    /// When a movie gets delete it should not cascade the delete to cast/crew members that still belong to another movie.
    func testCascadesDeleteMembersWhenBelongsToAnotherMovie() throws {
        let movieList = try MockedData.movieListResponse.mapToModel(of: TMDBResult<TMDBMovie>.self)
        let movie = Movie.insert(into: viewContext, movie: movieList.items[0])
        let otherMovie = Movie.insert(into: viewContext, movie: movieList.items[1])
        let crewMember = CrewMember.test(in: viewContext)
        let castMember = CastMember.test(in: viewContext)
        movie.addToCrew(crewMember)
        movie.addToCast(castMember)
        otherMovie.addToCrew(crewMember)
        otherMovie.addToCast(castMember)
        
        viewContext.delete(movie)
        try viewContext.save()
        
        XCTAssertNil(movie.managedObjectContext)
        XCTAssertNotNil(castMember.managedObjectContext)
        XCTAssertNotNil(crewMember.managedObjectContext)
    }
}
