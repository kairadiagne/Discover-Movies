//
//  Movie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 14-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

class Movie: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func test_InitializesFromDictionary() {
//        let movieDict = [ "id": 244786,
//                          "title": "Whiplash",
//                          "overview": "Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.",
//                          "release_date": "2014-10-10",
//                          "genre_ids": [18],
//                          "vote_average": 8.5,
//                          "adult": false,
//                          "poster_path": "/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg",
//                          "backdrop_path": "/6bbZ6XyvgfjhQwbplnUh1LSj1ky.jpg",
//                        ]
//        
//        let movie = Movie(dictionary: movieDict)
//        
//        XCTAssertNotNil(movie)
//        XCTAssertEqual(movie?.id, 244786)
//        XCTAssertEqual(movie?.title, "Whiplash")
//        XCTAssertEqual(movie?.overView, "Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.")
//        XCTAssertEqual(movie!.genres, [18])
//        XCTAssertEqual(movie?.rating, 8.5)
//        XCTAssertEqual(movie?.adult, false)
//        XCTAssertEqual(movie?.posterPath, "/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg")
//        XCTAssertEqual(movie?.backDropPath, "/6bbZ6XyvgfjhQwbplnUh1LSj1ky.jpg")
//    }
//    
//    func test_InstancesAreNotEqual() {
//        let movieDict = [ "id": 1,
//                          "title": "Whiplash",
//                          "overview": "Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.",
//                          "release_date": "2014-10-10",
//                          "genre_ids": [18],
//                          "vote_average": 8.5,
//                          "adult": false,
//                          "poster_path": "/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg",
//                          "backdrop_path": "/6bbZ6XyvgfjhQwbplnUh1LSj1ky.jpg",
//                          ]
//        
//        let movieDictTwo = [ "id": 2,
//                            "title": "Whiplash",
//                            "overview": "Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.",
//                            "release_date": "2014-10-10",
//                            "genre_ids": [18],
//                            "vote_average": 8.5,
//                            "adult": false,
//                            "poster_path": "/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg",
//                            "backdrop_path": "/6bbZ6XyvgfjhQwbplnUh1LSj1ky.jpg",
//                            ]
//        
//        let movie = Movie(dictionary: movieDict)
//        let movieTwo = Movie(dictionary: movieDictTwo)
//        
//        XCTAssertNotNil(movie)
//        XCTAssertNotNil(movieTwo)
//        XCTAssertNotEqual(movie, movieTwo)
//    }
//    
//    func test_InstancesAreEqual() {
//        let movieDict = [ "id": 1,
//                          "title": "Whiplash",
//                          "overview": "Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.",
//                          "release_date": "2014-10-10",
//                          "genre_ids": [18],
//                          "vote_average": 8.5,
//                          "adult": false,
//                          "poster_path": "/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg",
//                          "backdrop_path": "/6bbZ6XyvgfjhQwbplnUh1LSj1ky.jpg",
//                          ]
//        
//        let movie = Movie(dictionary: movieDict)
//        let movieTwo = Movie(dictionary: movieDict)
//        
//        XCTAssertNotNil(movie)
//        XCTAssertNotNil(movieTwo)
//        XCTAssertEqual(movie, movieTwo)
//    }
    
}
