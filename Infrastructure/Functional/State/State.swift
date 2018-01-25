//
//  State.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public struct State<S, A>: StateType {
    public typealias StateParameterType = S
    public typealias ParameterType = A
    
    private let callback: (S) -> (S, A)
    
    private init(_ callback: @escaping (S) -> (S, A)) {
        self.callback = callback
    }
    
    public static func from(concrete: State<S, A>) -> State<S, A> {
        return concrete
    }
    
    public func run(_ state: S) -> (S, A) {
        return callback(state)
    }
    
    public static func unfold(_ transform: @escaping (S) -> (S, A)) -> State<S, A> {
        return State.init(transform)
    }
}
