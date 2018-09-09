//
//  MovieSearchManager.swift
//  Careem
//
//  Created by Arnaldo on 9/5/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit
import SearchTextField

protocol SuggestionManagerProtocol {
    func loadSuggestions()
    var searchTextField: SearchTextField { get }
    var delegate: SuggestionsManagerDelegate? { get set }
    func save(_ suggestion: Suggestion)
}

protocol SuggestionsManagerDelegate: class {
    func didSelectSuggestion(value: String?)
}

class SuggestionsManager: NSObject, SuggestionManagerProtocol {
    weak var delegate: SuggestionsManagerDelegate?
    internal let searchTextField: SearchTextField = {
        let searchField = SearchTextField()
        searchField.borderStyle = .roundedRect
        searchField.theme.bgColor = UIColor.black.withAlphaComponent(0.7)
        searchField.placeholder = "Search a movie".localized
        searchField.theme.borderColor = .mainGray
        searchField.theme.fontColor = .white
        searchField.theme.subtitleFontColor = .mainGray
        searchField.clearButtonMode = .whileEditing
        searchField.theme.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        searchField.maxNumberOfResults = 10
        searchField.returnKeyType = .search
        searchField.autocorrectionType = .no
        return searchField
    }()

    override init() {
        super.init()
        setupViews()
        loadSuggestions()
    }
    
    internal func  loadSuggestions() {
        guard let suggestedList = try? SuggestionObject.er.all() else { return }
        searchTextField.filterItems((suggestedList.compactMap {
            let suggestion = Suggestion(managedObject: $0)
            return SearchTextFieldItem(title: suggestion.title, subtitle: String(suggestion.results) + " items found".localized)
        }))
        searchTextField.textFieldDidEndEditing()
    }
    
    private func setupViews() {
        searchTextField.itemSelectionHandler = { filteredResults, itemPosition in
            self.searchTextField.resignFirstResponder()
            self.delegate?.didSelectSuggestion(value: filteredResults[itemPosition].title)
        }
        searchTextField.userStoppedTypingHandler = {
            guard let text = self.searchTextField.text, (text.count > 5 || text.count == 0) else { return }
            let value = text == "" ? nil : text
            self.delegate?.didSelectSuggestion(value: value)
        }
    }
    
    internal func save(_ suggestion: Suggestion) {
        try? suggestion.managedObject().er.save(update: true)
    }
}
