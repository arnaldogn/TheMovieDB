//
//  MovieCascadeManager.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol MovieCascadeDelegate: class {
    func didSelect(movie: MovieDataModel)
    func didFinishSearch(_ error: CustomError?)
}

protocol MovieCascadeManagerProtocol {
    var view: MovieCascadeView { get }
    func loadMovies(query: String?, completion: ((Int)->())?)
    var delegate: MovieCascadeDelegate? { get set }
}

extension MovieCascadeManagerProtocol {
    func loadMovies(query: String?, completion: ((Int)->())? = nil) {
        return loadMovies(query: query, completion: completion)
    }
}

class MovieCascadeManager: NSObject, MovieCascadeManagerProtocol {
    var movieList = [Movie]()
    private let service: SearchMoviesServiceProtocol
    internal let view = MovieCascadeView(frame: .zero)
    weak var delegate: MovieCascadeDelegate?
    private var lastQuery: String?
    private var offset = 0
    private var totalPages = 1
    
    init(service: SearchMoviesServiceProtocol) {
        self.service = service
        super.init()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.defaultIdentifier)
    }
    
    private func checkNewSearch(query: String?) {
        if lastQuery != query {
            offset = 1
            movieList.removeAll()
        } else {
            offset += 1
        }
        lastQuery = query
    }
    
    internal func loadMovies(query: String?, completion: ((Int)->())?) {
        checkNewSearch(query: query)
        guard offset <= totalPages else { return }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        service.fetch(query: query, offset: offset) { (response, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            guard response?.results.count != 0 else {
                self.delegate?.didFinishSearch(CustomError(code: .noItems))
                return
            }
            guard error == nil, let response = response
                else {
                    self.delegate?.didFinishSearch(error)
                    return
            }
            self.totalPages = response.totalPages
            self.movieList += response.results
            self.view.collectionView.reloadData()
            completion?(response.totalResults)
        }
    }
}

extension MovieCascadeManagerProtocol {
    func loadMovies() {
        return loadMovies(query: nil)
    }
}

extension MovieCascadeManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        loadMoreMoviesIfNeeded(for: indexPath.row)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.defaultIdentifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: MovieDataModel(movieList[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(movie: MovieDataModel(movieList[indexPath.row]))
    }
    
    private func loadMoreMoviesIfNeeded(for row: Int) {
        let shouldLoadMoreItems = (row * 100)/movieList.count == 80
        if shouldLoadMoreItems {
            loadMovies(query: lastQuery)
        }
    }
}
