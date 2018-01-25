//
//  Reader.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public struct Reader<E, A>: ReaderType {
    public typealias EnvironmentType = E
    public typealias ParameterType = A
    
    private let callback: (E) -> A
    
    private init (_ callback: @escaping (E) -> A) {
        self.callback = callback
    }
    
    public static func from(concrete: Reader<E, A>) -> Reader<E, A> {
        return concrete
    }
    
    public func run(_ environment: E) -> A {
        return callback(environment)
    }
    
    public static func unfold(_ function: @escaping (E) -> A) -> Reader<E, A> {
        return Reader.init(function)
    }
}

