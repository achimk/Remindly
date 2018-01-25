//
//  XCTestCase+Additions.swift
//  FunctionalTests
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func getExpectation(_ description: String) -> XCTestExpectation {
        return expectation(description: description)
    }
    
    func checkExpectations(timeout: TimeInterval = 1) {
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func expecting(_ description: String, timeout: TimeInterval = 1, expectationFunction: (@escaping () -> ()) -> ()) {
        let a = getExpectation(description)
        expectationFunction({
            a.fulfill()
        })
        checkExpectations(timeout: timeout)
    }
    
    func expecting(_ description1: String, _ description2: String, timeout: TimeInterval = 1, expectationFunction: (@escaping () -> (), @escaping () -> ()) -> ()) {
        let a = getExpectation(description1)
        let b = getExpectation(description2)
        expectationFunction({
            a.fulfill()
        },{
            b.fulfill()
        })
        checkExpectations(timeout: timeout)
    }
    
    func expecting(_ description1: String, _ description2: String, _ description3: String, timeout: TimeInterval = 1, expectationFunction: (@escaping () -> (), @escaping () -> (), @escaping () -> ()) -> ()) {
        let a = getExpectation(description1)
        let b = getExpectation(description2)
        let c = getExpectation(description3)
        expectationFunction({
            a.fulfill()
        },{
            b.fulfill()
        },{
            c.fulfill()
        })
        checkExpectations(timeout: timeout)
    }
}

func after(_ delay: Double, _ execute: @escaping () -> ()) {
    let delayTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime, execute: execute)
}
