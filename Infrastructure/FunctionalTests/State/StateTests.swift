//
//  StateTests.swift
//  FunctionalTests
//
//  Created by Joachim Kret on 07.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
import Functional

class StateTests: XCTestCase {
    
    enum AppState {
        case running
    }
    
    typealias TestStateType<T> = State<AppState, T>
    let initialState = AppState.running
    
    func testLiftOneArg() {
        let id: (Int) -> Int = { $0 }
        let ap1 = TestStateType.pure(1)
        let result = (TestStateType.pure(id) <*> ap1).run(initialState)

        XCTAssertTrue(result == (initialState, 1))
    }
    
    func testLiftTwoArgs() {
        let sum: (Int,Int) -> Int = {$0 + $1}
        let ap1 = TestStateType.pure(1)
        let ap2 = TestStateType.pure(2)
        let result = (TestStateType.pure(fcurry(sum)) <*> ap1 <*> ap2).run(initialState)
        
        XCTAssertTrue(result == (initialState, 3))
    }
    
    func testLiftThreeArgs(){
        let sum: (Int,Int,Int) -> Int = {$0 + $1 + $2}
        let ap1 = TestStateType.pure(1)
        let ap2 = TestStateType.pure(2)
        let ap3 = TestStateType.pure(3)
        let result = (TestStateType.pure(fcurry(sum)) <*> ap1 <*> ap2 <*> ap3).run(initialState)
        
        XCTAssertTrue(result == (initialState, 6))
    }
}
