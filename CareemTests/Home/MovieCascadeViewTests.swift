//
//  MovieCascadeViewTests.swift
//  CareemTests
//
//  Created by Arnaldo on 9/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import XCTest
@testable import Careem

class MovieCascadeViewTests: XCTestCase {
    
    func testBasicConfiguration() {
        let view = MovieCascadeView()
        XCTAssertEqual(view.collectionView.superview, view)
        XCTAssertTrue(view.collectionView.collectionViewLayout is UICollectionViewFlowLayout)
        let layout = view.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        XCTAssertTrue(layout.scrollDirection == .vertical)
        let width = UIScreen.main.bounds.width
        let itemWidth = width/CGFloat(2)
        XCTAssertEqual(layout.itemSize, CGSize(width: itemWidth, height: itemWidth))
    }
    
}
