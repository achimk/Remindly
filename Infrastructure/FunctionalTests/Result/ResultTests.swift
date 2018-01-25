//
//  ResultTests.swift
//  FunctionalTests
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
import Functional

final class ResultTests: XCTestCase {
    
    func testMapTransformsSuccesses() {
        XCTAssertEqual(success.map { $0.count }.value, 7)
    }

    func testMapRewrapsFailures() {
        XCTAssertEqual(failure.map { $0.count }.value, nil)
    }
    
    func testInitOptionalSuccess() {
        XCTAssert(Result("success" as String?, failWith: error) == success)
    }
    
    func testInitOptionalFailure() {
        XCTAssert(Result(nil, failWith: error) == failure)
    }
    
    // MARK: Recover
    
    func testRecoverProducesLeftForLeftSuccess() {
        let left = Result<String, TestResultError>.success("left")
        XCTAssertEqual(left.recover("right"), "left")
    }
    
    func testRecoverProducesRightForLeftFailure() {
        let left = Result<String, TestResultError>.failure(TestResultError.a)
        XCTAssertEqual(left.recover("right"), "right")
    }
    
    // MARK: Recover With
    
    func testRecoverWithProducesLeftForLeftSuccess() {
        let left = Result<String, NSError>.success("left")
        let right = Result<String, NSError>.success("right")
        
        XCTAssertEqual(left.recover(with: right).value, "left")
    }
    
    func testRecoverWithProducesRightSuccessForLeftFailureAndRightSuccess() {
        struct Error: Swift.Error {}
        
        let left = Result<String, Error>.failure(Error())
        let right = Result<String, Error>.success("right")
        
        XCTAssertEqual(left.recover(with: right).value, "right")
    }
    
    func testRecoverWithProducesRightFailureForLeftFailureAndRightFailure() {
        enum Error: Swift.Error { case left, right }
        
        let left = Result<String, Error>.failure(.left)
        let right = Result<String, Error>.failure(.right)
        
        XCTAssertEqual(left.recover(with: right).error, .right)
    }

}


// MARK: - Fixtures

enum TestResultError: Swift.Error, LocalizedError {
    case a, b

    var errorDescription: String? {
        return "localized description"
    }

    var failureReason: String? {
        return "failure reason"
    }

    var helpAnchor: String? {
        return "help anchor"
    }

    var recoverySuggestion: String? {
        return "recovery suggestion"
    }
}

extension ResultTests {
    
    struct AnyError: Swift.Error {
        let error: Swift.Error
        
        init(_ error: Swift.Error) {
            if let anyError = error as? AnyError {
                self = anyError
            } else {
                self.error = error
            }
        }
    }
}

let success = Result<String, ResultTests.AnyError>.success("success")
let error = ResultTests.AnyError(TestResultError.a)
let error2 = ResultTests.AnyError(TestResultError.b)
let error3 = ResultTests.AnyError(NSError(domain: "Result", code: 42, userInfo: [NSLocalizedDescriptionKey: "localized description"]))
let failure = Result<String, ResultTests.AnyError>.failure(error)
let failure2 = Result<String, ResultTests.AnyError>.failure(error2)

// MARK: - Helpers

extension ResultTests.AnyError: Equatable {
    public static func ==(lhs: ResultTests.AnyError, rhs: ResultTests.AnyError) -> Bool {
        return lhs.error._code == rhs.error._code
            && lhs.error._domain == rhs.error._domain
    }
}

