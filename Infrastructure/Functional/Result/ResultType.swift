//
//  ResultType.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol ResultType: PureConstructible, CoproductType {
    associatedtype ErrorType: Swift.Error
    
    func run() throws -> ParameterType

    func fold <A> (onSuccess: (ParameterType) -> A, onFailure: (ErrorType) -> A) -> A
    
    static func from(concrete: Concrete<ParameterType, ErrorType>) -> Self
}

// MARK: - Concrete

extension ResultType {
    public typealias Concrete<T, E> = Result<T, E> where E: Swift.Error
}

// MARK: - Coproduct

extension ResultType {
    
    public func fold <U> (onLeft: (ParameterType) -> U, onRight: (ErrorType) -> U) -> U {
        return fold(onSuccess: onLeft, onFailure: onRight)
    }
}

// MARK: - Equatable

extension ResultType where ErrorType: Equatable, ParameterType: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.fold(
            onSuccess: { value in
                rhs.fold(
                    onSuccess: { value == $0 },
                    onFailure: { _ in false }
                )
        },
            onFailure: { error in
                rhs.fold(
                    onSuccess: { _ in false },
                    onFailure: { error == $0 }
                )
        })
    }
}

// MARK: Utils

extension ResultType {
    
    public var error: ErrorType? {
        return fold(
            onSuccess: fconstant(nil),
            onFailure: fidentity
        )
    }
    
    public var value: ParameterType? {
        return fold(
            onSuccess: fidentity,
            onFailure: fconstant(nil)
        )
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var isSuccess: Bool {
        return fold(
            onSuccess: fconstant(true),
            onFailure: fconstant(false)
        )
    }
    
    public func map <A> (_ transform: (ParameterType) -> A) -> Result<A, ErrorType> {
        return fold(
            onSuccess: { Result.success(transform($0)) },
            onFailure: Result.failure
        )
    }
    
    public func mapError <A> (_ transform: (ErrorType) -> A) -> Result<ParameterType, A> {
        return fold(
            onSuccess: Result.success,
            onFailure: { Result.failure(transform($0)) }
        )
    }

    public func flatMap <R> (_ transform: (ParameterType) -> R) -> Result<R.ParameterType, ErrorType> where R: ResultType, R.ErrorType == ErrorType {
        return map(transform).fold(
            onSuccess: {
                $0.fold(
                    onSuccess: Result.success,
                    onFailure: Result.failure
                )
            },
            onFailure: Result.failure
        )
    }
    
    public func recover(_ value: @autoclosure () -> ParameterType) -> ParameterType {
        return fold(
            onSuccess: fidentity,
            onFailure: fconstant(value())
        )
    }
    
    public func recover(with result: @autoclosure () -> Result<ParameterType, ErrorType>) -> Result<ParameterType, ErrorType> {
        return fold(
            onSuccess: Result.success,
            onFailure: fconstant(result())
        )
    }

    public static func pure(_ value: ParameterType) -> Result<ParameterType, ErrorType> {
        return Result<ParameterType, ErrorType>.success(value)
    }

}
