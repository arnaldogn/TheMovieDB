//
//  UIViewController+Extensions.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

extension UIViewController {
    func showMessage(title: String = "Error", _ message: String? = "Ups, something went wrong".localized) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok".localized, style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
