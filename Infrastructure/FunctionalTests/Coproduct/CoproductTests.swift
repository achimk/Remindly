//
//  CoproductTests.swift
//  FunctionalTests
//
//  Created by Joachim Kret on 07.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
import Functional

typealias TestType = Coproduct<Int, String>

class CoproductTests: XCTestCase {
    
    func testTry() {
        XCTAssertNotNil(TestType.left(42).left)
        XCTAssertNil(TestType.left(42).right)
        
        XCTAssertNil(TestType.right("42").left)
        XCTAssertNotNil(TestType.right("42").right)
    }
    
    func testFold() {
        XCTAssertTrue(TestType.left(42).fold(onLeft: fconstant(true), onRight: fconstant(false)))
        XCTAssertTrue(TestType.right("42").fold(onLeft: fconstant(false), onRight: fconstant(true)))
        
        XCTAssertEqual(TestType.left(42).foldToLeft { Int($0)! }, 42)
        XCTAssertEqual(TestType.right("42").foldToRight { "\($0)" }, "42")
    }
    
    func testMap() {
        XCTAssertEqual(TestType.left(42).bimap(fidentity, { Int($0)! }).left, 42)
        XCTAssertEqual(TestType.right("42").bimap({ "\($0)" }, fidentity).right, "42")
        
        XCTAssertEqual(TestType.left(42).mapLeft { $0*2 }.left!, 84)
        XCTAssertEqual(TestType.left(42).mapRight { $0 + "!" }.left!, 42)
        
        XCTAssertEqual(TestType.right("42").mapLeft { $0*2 }.right!, "42")
        XCTAssertEqual(TestType.right("42").mapRight { $0 + "!" }.right!, "42!")
    }
}

