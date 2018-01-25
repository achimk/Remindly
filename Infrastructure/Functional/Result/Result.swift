//
//  Result.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public enum Result<T, E>: ResultType where E: Swift.Error {
    public typealias ErrorType = E
    public typealias ParameterType = T
    
    case success(T)
    case failure(E)
    
    public init(value: T) {
        self = .success(value)
    }
    
    public init(error: E) {
        self = .failure(error)
    }
    
    public init(_ value: T?, failWith: @autoclosure () -> E) {
        self = value.map(Result.success) ?? .failure(failWith())
    }
    
    public static func from(concrete: Result<T, E>) -> Result<T, E> {
        return concrete
    }
    
    public func run() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
    public func fold <A> (onSuccess: (T) -> A, onFailure: (E) -> A) -> A {
        switch self {
        case .success(let value):
            return onSuccess(value)
        case .failure(let error):
            return onFailure(error)
        }
    }
}
