//
//  CustomError.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

enum APIError: String {
    case noItems = "No results found"
}

struct CustomError: Codable {
    var errors: [String]?
    var message: String? { get { return errors?.first } }
    
    init(_ error: Error? = nil) {
        guard let error = error?.localizedDescription
            else {
                self.errors = ["Ups something went wrong".localized]
                return
        }
        self.errors = [error]
    }
    
    init(code: APIError) {
        self.errors = [code.rawValue]
    }
}
