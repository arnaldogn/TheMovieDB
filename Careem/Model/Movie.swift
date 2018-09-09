//
//  Movie.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import RealmSwift

struct MovieList : Codable {
    let id: Int?
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let vote: Float
    var posterPath: String?
    let overview: String
    let releaseDate: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case vote = "vote_average"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
}
