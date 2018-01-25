//
//  Future.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

private enum FutureState<T> {
    case idle
    case running
    case done(T)
}

public final class Future<A>: FutureType {
    public typealias ParameterType = A
    
    private var callbacks: [(A) -> ()] = []
    private var currentState = FutureState<A>.idle
    private let continuation: (@escaping (A) -> ()) -> ()
    
    public static func from(concrete: Future<A>) -> Future<A> {
        return concrete
    }
    
    private init(_ continuation: @escaping (@escaping (A) -> ()) -> ()) {
        self.continuation = continuation
    }
    
    @discardableResult
    public func start() -> Future<A> {
        guard case .idle = currentState else { return self }
        currentState = .running
        continuation { value in
            self.currentState = .done(value)
            self.callbacks.forEach { $0(value) }
            self.callbacks.removeAll()
        }
        return self
    }
    
    public func run(_ callback: @escaping (A) -> ()) {
        switch currentState {
        case .idle:
            callbacks.append(callback)
            start()
        case .running:
            callbacks.append(callback)
        case .done(let value):
            callback(value)
        }
    }
    
    public static func unfold(_ continuation: @escaping (@escaping (A) -> ()) -> ()) -> Future<A> {
        return Future<A>.init(continuation)
    }
}

extension Future where A: Equatable {
    
    public static func == (lhs: Future, rhs: Future) -> Bool {
        switch (lhs.currentState, rhs.currentState) {
        case (.idle, .idle): return true
        case (.running, .running): return true
        case(.done(let left), .done(let right)): return left == right
        default: return false
        }
    }
}
