//
//  FetchMoviesService.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Alamofire

typealias SearchMoviesCompletionBlock = (_ result: MovieList?, _ error: CustomError?) -> ()

protocol SearchMoviesServiceProtocol {
    func fetch(query: String?, offset: Int, _ completion: @escaping SearchMoviesCompletionBlock)
}

extension SearchMoviesServiceProtocol {
    func fetch(query: String? = nil, offset: Int = 1, _ completion: @escaping SearchMoviesCompletionBlock) {
        return fetch(query: query, offset: offset, completion)
    }
}

class SearchMoviesService: SearchMoviesServiceProtocol {
    private var tmdbAPIKey: String? {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary?["Tmdb"] as? [String: Any] else {
            return nil
        }
        return infoDictionary["APIKey"] as? String
    }
    internal func fetch(query: String?, offset: Int, _ completion: @escaping SearchMoviesCompletionBlock) {
        let url = query == nil ? Constants.Url.discover : Constants.Url.search
        guard let urlComponents = NSURLComponents(string: url) else { return }
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: tmdbAPIKey),
                                    URLQueryItem(name: "page", value: String(offset)),
                                    URLQueryItem(name: "query", value: query)]
        
        guard let searchUrl = urlComponents.url else { return }
        return DependencyManager.resolve(interface: APIManagerProtocol.self).request(url: searchUrl.absoluteString, completion: completion)
    }
}
