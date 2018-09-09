//
//  Constants.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

enum Constants {
    enum Url {
        static let base = "https://api.themoviedb.org/3/"
        static let search = base + "search/movie"
        static let discover = base + "discover/movie"
        static let posterBase = "https://image.tmdb.org/t/p"
        static let poster = posterBase + "/w500"
    }
}
