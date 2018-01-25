//
//  Writer.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public struct Writer<L, A>: WriterType where L: Monoid {
    public typealias ParameterType = A
    public typealias LogType = L
    
    fileprivate let log: L
    fileprivate let value: A
    
    public init(log: L, value: A) {
        self.log = log
        self.value = value
    }
    
    public static func from(concrete: Writer<L, A>) -> Writer<L, A> {
        return concrete
    }
    
    public var run: (L, A) {
        return (log, value)
    }
    
    public func fold<T>(_ transform: (L, A) -> T) -> T {
        let pair = run
        return transform(pair.0, pair.1)
    }
}

