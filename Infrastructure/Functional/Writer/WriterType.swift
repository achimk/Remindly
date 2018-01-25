//
//  WriterType.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// MARK: - WriterType

public protocol WriterType: PureConstructible, ProductType {
    associatedtype LogType: Monoid
    
    var run: (LogType,ParameterType) { get }
    
    func fold <T> (_ transform: (LogType,ParameterType) -> T) -> T
    
    static func from(concrete: Concrete<LogType,ParameterType>) -> Self
}

// MARK: - Concrete

extension WriterType {
    public typealias Concrete<L,T> = Writer<L,T> where L: Monoid
}

// MARK: - Equatable

extension WriterType where LogType: Equatable, ParameterType: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.fold { l1, v1 in rhs.fold { l2, v2 in l1 == l2 && v1 == v2 } }
    }
}

// MARK: Utils

extension WriterType {
    
    public func tell(_ newLog: LogType) -> Writer<LogType, ParameterType> {
        let (oldLog, value) = run
        return Writer.init(log: oldLog.appending(newLog), value: value)
    }
    
    public func remember(_ oldLog: LogType) -> Writer<LogType,ParameterType> {
        let (newLog, value) = run
        return Writer.init(log: oldLog.appending(newLog), value: value)
    }
    
    public func read(_ transform: (ParameterType) -> LogType) -> Writer<LogType, ParameterType> {
        let (log, value) = run
        return Writer.init(log: log.appending(transform(value)), value: value)
    }
    
    public var listen: Writer<LogType,(LogType,ParameterType)> {
        let (log,value) = run
        return Writer(log: log, value: (log,value))
    }
    
    public func map <T> (_ transform: (ParameterType) -> T) -> Writer<LogType,T> {
        return fold { log, value in Writer<LogType,T>.init(log: log, value: transform(value)) }
    }
    
    public func mapLog <T> (_ transform: (LogType) -> T) -> Writer<T,ParameterType> where T: Monoid {
        return fold { log, value in Writer<T,ParameterType>.init(log: transform(log), value: value) }
    }
    
    public func flatMap <W> (_ transform: (ParameterType) -> W) -> Writer<LogType, W.ParameterType> where W: WriterType, W.LogType == LogType {
        return map(transform).fold { externalLog, externalValue in
            externalValue.fold { internalLog, internalValue in
                Writer.init(log: externalLog.appending(internalLog), value: internalValue)
            }
        }
    }
    
    public func apply <W, T> (_ transform: W) -> Writer<LogType, T> where W: WriterType, W.ParameterType == (ParameterType) -> T, W.LogType == LogType {
        return fold { l1, v1 in transform.fold { l2, v2 in Writer.init(log: l1.appending(l2), value: (v1, v2)) } }.map { value, function in function(value) }
    }
    
    public static func <*> <W, T> (lhs: W, rhs: Self) -> Writer<LogType, T> where W: WriterType, W.ParameterType == (ParameterType) -> T, W.LogType == LogType {
        return rhs.fold { l1, v1 in lhs.fold { l2, v2 in Writer.init(log: l1.appending(l2), value: (v1, v2)) } }.map { value, function in function(value) }
    }
    
    public static func pure(_ value: ParameterType) -> Writer<LogType,ParameterType> {
        return Writer.init(log: .zero, value: value)
    }
}

