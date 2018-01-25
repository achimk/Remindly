//
//  FutureTests.swift
//  FunctionalTests
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
import Functional

class FutureTests: XCTestCase {
    
    func testLiftOneArg() {
        let ap1 = Future.pure(1)
        
        expecting("testLiftOneArg") { (fulfill) in
            ap1.run({ value in
                XCTAssert(value == 1)
                fulfill()
            })
        }
    }
    
    func testLiftTwoArgs() {
        let sum: (Int, Int) -> Int = {$0 + $1}
        let apSum = Future.pure(fcurry(sum))
        let ap1 = Future.pure(1)
        let ap2 = Future.pure(2)
        let operation = apSum <*> ap1 <*> ap2

        expecting("testLiftTwoArgs") { (fulfill) in
            operation.run({ (value) in
                XCTAssert(value == 3)
                fulfill()
            })
        }
    }
    func testLiftThreeArgs(){
        let sum: (Int, Int, Int) -> Int = {$0 + $1 + $2}
        let apSum = Future.pure(fcurry(sum))
        let ap1 = Future.pure(1)
        let ap2 = Future.pure(2)
        let ap3 = Future.pure(3)
        let operation = apSum <*> ap1 <*> ap2 <*> ap3
        
        expecting("testLiftThreeArgs") { (fulfill) in
            operation.run { value in
                XCTAssert(value == 6)
                fulfill()
            }
        }
    }

    func testAsync() {
        expecting("Future completes") { fulfill in
            let f = Future<String>.unfold { done in
                DispatchQueue.main.async {
                    done("test")
                    fulfill()
                }
            }
            f.start()
        }
    }
    
    func testMemoryLeak() {
        expecting("Future completes", "Future is dismissed") { fulfillComplete, fulfillDismiss in
            let expectedText = "expectedText"
            var f: Future<String>? = Future<String>.unfold { done in
                after(0.1) {
                    done(expectedText)
                }
            }
            weak var fWeak = f
            f?.run { value in
                XCTAssertEqual(value, expectedText)
                fulfillComplete()
            }
            
            f = nil
            XCTAssertNotNil(fWeak)
            
            after(0.3) {
                XCTAssertNil(fWeak)
                fulfillDismiss()
            }
        }
    }
}
