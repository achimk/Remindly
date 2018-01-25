//
//  ReaderType.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// MARK: - ReaderType

public protocol ReaderType: PureConstructible {
    associatedtype EnvironmentType
    
    func run(_ environment: EnvironmentType) -> ParameterType
    
    static func from(concrete: Concrete<EnvironmentType, ParameterType>) -> Self
    
    static func unfold(_ function: @escaping (EnvironmentType) -> ParameterType) -> Self
}

// MARK: - Concrete

extension ReaderType {
    public typealias Concrete<E,T> = Reader<E,T>
}

// MARK: - Utils

extension ReaderType {

    public func map <T> (_ transform: @escaping (ParameterType) -> T) -> Reader<EnvironmentType, T> {
        return Reader.unfold { e in transform(self.run(e)) }
    }
    
    public func flatMap <R> (_ transform: @escaping (ParameterType) -> R) -> Reader<EnvironmentType, R.ParameterType> where R: ReaderType, R.EnvironmentType == EnvironmentType {
        return Reader.unfold { e in transform(self.run(e)).run(e) }
    }
    
    public func apply <R, T> (_ transform: R) -> Reader<EnvironmentType, T> where R: ReaderType, R.ParameterType == (ParameterType) -> T, R.EnvironmentType == EnvironmentType {
        return Reader.unfold { e in (self.run(e), transform.run(e)) }.map { value, function in function(value) }
    }
    
    public static func <*> <R, T> (lhs: R, rhs: Self) -> Reader<EnvironmentType, T> where R: ReaderType, R.ParameterType == (ParameterType) -> T, R.EnvironmentType == EnvironmentType {
        return Reader.unfold { e in (rhs.run(e), lhs.run(e)) }.map { value, function in function(value) }
    }
    
    public static func pure(_ value: ParameterType) -> Reader<EnvironmentType, ParameterType> {
        return Reader.unfold(fconstant(value))
    }
    
    public static var ask: Reader<EnvironmentType, EnvironmentType> {
        return Reader<EnvironmentType, EnvironmentType>.unfold(fidentity)
    }
    
    public static func zip <R1, R2> (_ first: R1, _ second: R2) -> Reader<(R1.EnvironmentType, R2.EnvironmentType), (R1.ParameterType, R2.ParameterType)> where R1: ReaderType, R2: ReaderType, EnvironmentType == (R1.EnvironmentType, R2.EnvironmentType), ParameterType == (R1.ParameterType, R2.ParameterType) {
        return Reader.unfold { e1, e2 in (first.run(e1), second.run(e2)) }
    }
}
