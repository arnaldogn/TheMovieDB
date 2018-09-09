//
//  ViewController.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit
import EasyRealm

protocol HomeViewControllerDelegate: class {
    func showDetails(for movie: MovieDataModel)
}

class HomeViewController: UIViewController {
    var cascadeManager = DependencyManager.resolve(interface: MovieCascadeManagerProtocol.self)
    var suggestionsManager = DependencyManager.resolve(interface: SuggestionManagerProtocol.self)
    weak var delegate: HomeViewControllerDelegate?
    private let headerView = UIView()
    
    override func viewDidLoad() {
          super.viewDidLoad()
        setupViews()
        cascadeManager?.loadMovies()
    }
    
    private func setupViews() {
        title = "MovieDB".localized
        edgesForExtendedLayout = []
        guard var cascadeManager = cascadeManager,
            var suggestionsManager = suggestionsManager else { return }
        cascadeManager.delegate = self
        suggestionsManager.delegate = self
        headerView.backgroundColor = .mainGray
        headerView.addSubviewsForAutolayout(suggestionsManager.searchTextField)
        view.addSubviewsForAutolayout(cascadeManager.view, headerView)
        setupConstraints()
    }

    func setupConstraints() {
        guard let cascadeManager = cascadeManager,
            let suggestionsManager = suggestionsManager else { return }

        let views = ["cascade": cascadeManager.view,
                     "searchField": suggestionsManager.searchTextField,
                     "headerView": headerView]
        view.addConstraints(
            NSLayoutConstraint.constraints("H:|[headerView]|", views: views),
            NSLayoutConstraint.constraints("H:|-15-[searchField]-60-|", views: views),
            NSLayoutConstraint.constraints("H:|[cascade]|", views: views),
            NSLayoutConstraint.constraints("V:|-8-[searchField(35)]-8-|", views: views),
            NSLayoutConstraint.constraints("V:|[headerView][cascade]|", views: views))
    }
}

extension HomeViewController: MovieCascadeDelegate {
    func didFinishSearch(_ error: CustomError?) {
        if error != nil {
            showMessage(title: "Error".localized, error?.message)
        }
    }
    
    func didSelect(movie: MovieDataModel) {
       delegate?.showDetails(for: movie)
    }
}

extension HomeViewController: SuggestionsManagerDelegate {
    func didSelectSuggestion(value: String?) {
        cascadeManager?.loadMovies(query: value, completion: {
            if let value = value {
                self.suggestionsManager?.save(Suggestion(title: value, results: $0))
                self.suggestionsManager?.loadSuggestions()
            }
        })
    }
}

