//
//  Coordinators.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
