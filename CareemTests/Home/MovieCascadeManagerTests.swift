//
//  MovieCascadeManagerTests.swift
//  CareemTests
//
//  Created by Arnaldo on 9/8/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import XCTest
@testable import Careem

class MovieCascadeManagerTests: XCTestCase {
    var manager: MovieCascadeManager?
    override func setUp() {
        super.setUp()
        manager = MovieCascadeManager(service: FakeSearchMovieService())
    }
    
    func testLoadMovies() {
        manager?.loadMovies(query: nil) { (count) in
            XCTAssertTrue(count == 1)
            XCTAssertTrue(self.manager?.movieList.count == 1)
            let movie = self.manager?.movieList.first
            XCTAssertTrue(movie?.title == "FakeTitle")
            XCTAssertTrue(movie?.overview == "FakeDescription")
        }
    }
}
