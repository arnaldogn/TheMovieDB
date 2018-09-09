//
//  SuggestionsManagerTests.swift
//  CareemTests
//
//  Created by Arnaldo on 9/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import XCTest
@testable import Careem

class SuggestionsManagerTests: XCTestCase {

    var manager: SuggestionsManager?
    let fakeSuggestion = Suggestion(title: "FakeTitle", results: 1)
    var fakeDelegate: FakeSuggestionManagerDelegate?
    
    override func setUp() {
        super.setUp()
        manager = SuggestionsManager()
        fakeDelegate = FakeSuggestionManagerDelegate()
        manager?.delegate = fakeDelegate
        manager?.save(suggestion: fakeSuggestion)
    }

    func testBasicConfiguration() {
        XCTAssertEqual(manager?.searchTextField.maxNumberOfResults, 10)
    }
    
    func testLoadSuggestion() {
        manager?.searchTextField.text = "FakeTitle"
        manager?.searchTextField.userStoppedTypingHandler!()
        
        XCTAssertTrue(fakeDelegate!.wasCalled)
        XCTAssertEqual(fakeDelegate?.suggestedValue, "FakeTitle")
    }
}
