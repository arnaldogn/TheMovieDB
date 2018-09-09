//
//  MovieDataModel.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

class MovieDataModel: NSObject {
    let movie: Movie
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    var title: String {
        return movie.title
    }
    var votes: String {
        return String(format: "%.1f", movie.vote)
    }
    var overview: String {
        return movie.overview
    }
    var releaseDate: String? {
        return movie.releaseDate
    }
    var posterUrl: URL? {
        guard let filename = movie.posterPath else { return nil }
        return URL(string: Constants.Url.poster + filename)
    }
}
