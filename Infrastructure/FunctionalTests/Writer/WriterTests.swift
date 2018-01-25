//
//  WriterTests.swift
//  FunctionalTests
//
//  Created by Joachim Kret on 07.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
import Functional

class WriterTests: XCTestCase {
    
    struct Log: Monoid, Equatable {
        var log: [String] = []
        static var zero = Log(log: [])
        
        func appending(_ other: Log) -> Log {
            return Log(log: log + other.log)
        }

        static func ==(lhs: Log, rhs: Log) -> Bool {
            return lhs.log == rhs.log
        }
    }
    
    typealias TestWriterType<T> = Writer<Log,T>
    
    func testLiftOneArg() {
        let id: (Int) -> Int = { $0 }
        let ap1 = TestWriterType.pure(1)
        let apSum = TestWriterType.pure(id) <*> ap1

        XCTAssertTrue(apSum == ap1)
    }
    
    func testLiftTwoArgs() {
        let sum: (Int,Int) -> Int = {$0 + $1}
        let ap1 = TestWriterType.pure(1)
        let ap2 = TestWriterType.pure(2)
        let apSum = TestWriterType.pure(fcurry(sum)) <*> ap1 <*> ap2

        XCTAssertTrue(apSum == TestWriterType.pure(3))
    }
    
    func testLiftThreeArgs(){
        let sum: (Int,Int,Int) -> Int = {$0 + $1 + $2}
        let ap1 = TestWriterType.pure(1)
        let ap2 = TestWriterType.pure(2)
        let ap3 = TestWriterType.pure(3)
        let apSum = TestWriterType.pure(fcurry(sum)) <*> ap1 <*> ap2 <*> ap3
        
        XCTAssertTrue(apSum == TestWriterType.pure(6))
    }
}



