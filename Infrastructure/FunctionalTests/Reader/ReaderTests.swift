//
//  ReaderTests.swift
//  FunctionalTests
//
//  Created by Joachim Kret on 07.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
import Functional

class ReaderTests: XCTestCase {
    
    struct Environment: Equatable {
        var environment = "Production"
        
        static func ==(lhs: ReaderTests.Environment, rhs: ReaderTests.Environment) -> Bool {
            return lhs.environment == rhs.environment
        }
    }
    
    typealias TestReaderType<T> = Reader<Environment,T>
    let environment = Environment()
    
    func testLiftOneArg() {
        let id: (Int) -> Int = { $0 }
        let ap1 = TestReaderType.pure(1)
        let result = (TestReaderType.pure(id) <*> ap1).run(environment)
        
        XCTAssertEqual(result, 1)
    }
    
    func testLiftTwoArgs() {
        let sum: (Int,Int) -> Int = { $0 + $1 }
        let ap1 = TestReaderType.pure(1)
        let ap2 = TestReaderType.pure(2)
        let result = (TestReaderType.pure(fcurry(sum)) <*> ap1 <*> ap2).run(environment)
        
        XCTAssertEqual(result, 3)
    }
    
    func testLiftThreeArgs(){
        let sum: (Int,Int,Int) -> Int = {$0 + $1 + $2}
        let ap1 = TestReaderType.pure(1)
        let ap2 = TestReaderType.pure(2)
        let ap3 = TestReaderType.pure(3)
        let result = (TestReaderType.pure(fcurry(sum)) <*> ap1 <*> ap2 <*> ap3).run(environment)
        
        XCTAssertEqual(result, 6)
    }
    
    func testAsk() {
        expecting("testAsk") { (fulfill) in
            let r = TestReaderType<Int>.ask.map { environment -> (ReaderTests.Environment) in
                XCTAssertEqual(environment.environment, "Test")
                fulfill()
                return Environment(environment: "Result")
            }
            
            let result = r.run(Environment(environment: "Test"))
            
            XCTAssertEqual(result, Environment(environment: "Result"))
        }
    }
}
