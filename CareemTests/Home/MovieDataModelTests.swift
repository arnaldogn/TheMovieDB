//
//  MovieDataModelTests.swift
//  CareemTests
//
//  Created by Arnaldo on 9/8/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import XCTest
@testable import Careem

class LocalDealDataModelTests: XCTestCase {
    func testLocalDealDataModel() {
        let movie = Movie(id: 1, title: "FakeTitle", vote: 1, posterPath: nil, overview: "FakeDescription", releaseDate: nil)
        let model = MovieDataModel(movie)
        XCTAssertEqual(model.title, movie.title)
        XCTAssertEqual(model.overview, model.overview)
    }
}
