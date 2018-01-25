//
//  FutureType.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// MARK: - FutureType

public protocol FutureType: PureConstructible {
    
    func run (_ callback: @escaping (ParameterType) -> ())
    
    static func from(concrete: Concrete<ParameterType>) -> Self
    
    static func unfold(_ continuation: @escaping (@escaping (ParameterType) -> ()) -> ()) -> Self
}

// MARK: - Concrete

extension FutureType {
    public typealias Concrete<T> = Future<T>
}

// MARK: - Utils

extension FutureType {
    
    public func map <T> (_ transform: @escaping (ParameterType) -> T) -> Future<T> {
        return Future.unfold { done in
            self.run { value in done(transform(value)) }
        }
    }

    public func flatMap <F> (_ transform: @escaping (ParameterType) -> F) -> Future<F.ParameterType> where F: FutureType {
        return Future.unfold { done in self.map(transform).run { $0.run(done) } }
    }
    
    public func apply <F, T> (_ transform: F) -> Future<T> where F: FutureType, F.ParameterType == (ParameterType) -> T {
        return Future.zip(self, transform).map { value, function in function(value) }
    }
    
    public static func <*> <F, T> (lhs: F, rhs: Self) -> Future<T> where F: FutureType, F.ParameterType == (ParameterType) -> T {
        return Future.zip(lhs, rhs).map { function, value in function(value) }
    }
    
    public static func pure(_ value: ParameterType) -> Future<ParameterType> {
        return Future.unfold { $0(value) }.start()
    }
    
    public static func zip <F1, F2> (_ first: F1, _ second: F2) -> Future<(F1.ParameterType, F2.ParameterType)> where F1: FutureType, F2: FutureType, ParameterType == (F1.ParameterType,F2.ParameterType) {
        
        return Future.unfold { done in
            var tuple: (F1.ParameterType?,F2.ParameterType?) = (nil,nil)
            
            first.run { value in
                tuple.0 = value
                guard let first = tuple.0, let second = tuple.1 else { return }
                done((first,second))
            }
            
            second.run { value in
                tuple.1 = value
                guard let first = tuple.0, let second = tuple.1 else { return }
                done((first,second))
            }
        }
    }
}
