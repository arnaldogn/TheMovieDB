//
//  MainCoordinator.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
      showDashboard()
    }
    
    func showDashboard() {
        let homeVC = HomeViewController()
        homeVC.delegate = self
        navigationController.pushViewController(homeVC, animated: true)
    }
}

extension MainCoordinator: HomeViewControllerDelegate {
    func showDetails(for movie: MovieDataModel) {
        navigationController.pushViewController(MovieDetailViewController(movie: movie), animated: true)
    }    
}


