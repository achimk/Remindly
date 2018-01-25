//
//  ProductTests.swift
//  FunctionalTests
//
//  Created by Joachim Kret on 07.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
import Functional

class ProductTests: XCTestCase {
    
    func testFold() {
        let result = Product.init(42, "!").fold { "\($0)" + $1 }
        XCTAssertEqual(result, "42!")
    }
    
    func testMap() {
        XCTAssertTrue(Product.init(42, "42").bimap({ $0 }, { Int($0)! }).unwrap == (42, 42))
        XCTAssertEqual(Product.init(42, "42").mapFirst { $0 + 1 }.first, 43)
        XCTAssertEqual(Product.init(42, "42").mapFirst { $0 + 1 }.second, "42")
        XCTAssertEqual(Product.init(42, "42").mapSecond { $0 + "!" }.first, 42)
        XCTAssertEqual(Product.init(42, "42").mapSecond { $0 + "!" }.second, "42!")
    }
}

