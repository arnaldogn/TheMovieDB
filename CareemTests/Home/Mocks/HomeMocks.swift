//
//  HomeMocks.swift
//  CareemTests
//
//  Created by Arnaldo on 9/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation
@testable import Careem

class FakeSearchMovieService: SearchMoviesServiceProtocol {
    
    let fakeMovieList = MovieList(id: 1, results: [Movie(id: 1, title: "FakeTitle", vote: 1, posterPath: nil, overview: "FakeDescription", releaseDate: nil)], totalPages: 1, totalResults: 1)
    
    func fetch(query: String?, offset: Int, _ completion: @escaping SearchMoviesCompletionBlock) {
        return completion(fakeMovieList, nil)
    }
}

class FakeSuggestionManagerDelegate: SuggestionsManagerDelegate {
    var wasCalled = false
    var suggestedValue: String?
    func didSelectSuggestion(value: String?) {
        wasCalled = true
        suggestedValue = value
    }
}
