//
//  Suggestion.swift
//  Careem
//
//  Created by Arnaldo on 9/6/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import RealmSwift

struct Suggestion {
    var title: String
    var results: Int
}

final public class SuggestionObject: Object {
    @objc dynamic var title = ""
    @objc dynamic var results = 0
    
    override public static func primaryKey() -> String? {
        return "title"
    }
}

extension Suggestion: Persistable {
    public init(managedObject: SuggestionObject) {
        title = managedObject.title
        results = managedObject.results
    }
    
    public func managedObject() -> SuggestionObject {
        let suggestionObject = SuggestionObject()
        suggestionObject.title = title
        suggestionObject.results = results
        return suggestionObject
    }
}
