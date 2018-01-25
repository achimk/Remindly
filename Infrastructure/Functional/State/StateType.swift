//
//  StateType.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// MARK: - StateType

public protocol StateType: PureConstructible {
    associatedtype StateParameterType
    
    func run(_ state: StateParameterType) -> (StateParameterType, ParameterType)
    
    static func from(concrete: Concrete<StateParameterType, ParameterType>) -> Self
    
    static func unfold(_ transform: @escaping (StateParameterType) -> (StateParameterType, ParameterType)) -> Self
}

// MARK: - Concrete

extension StateType {
    public typealias Concrete<S, T> = State<S, T>
}

// MARK: - Equatable

extension StateType where StateParameterType: Equatable, ParameterType: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Reader<StateParameterType, Bool> {
        return Reader.unfold { s in
            lhs.run(s) == rhs.run(s)
        }
    }
}

// MARK: Utils

extension StateType {
    
    public static var get: State<StateParameterType, StateParameterType> {
        return State<StateParameterType, StateParameterType>.unfold { s in (s,s) }
    }
    
    public static func put(_ state: StateParameterType) -> State<StateParameterType, ()> {
        return State<StateParameterType, ()>.unfold { _ in (state, ()) }
    }
    
    public func map <T> (_ transform: @escaping (ParameterType) -> T) -> State<StateParameterType, T> {
        return State.unfold { s in
            let (newS,v) = self.run(s)
            return (newS,transform(v))
        }
    }
    
    public func mapState <T> (from: @escaping (T) -> StateParameterType, to: @escaping (StateParameterType) -> T) -> State<T,ParameterType> {
        return State.unfold { t in
            let (newS,v) = self.run(from(t))
            return (to(newS),v)
        }
    }
    
    public func flatMap <S> (_ transform: @escaping (ParameterType) -> S) -> State<StateParameterType, S.ParameterType> where S: StateType, S.StateParameterType == StateParameterType {
        return State.unfold { externalS in
            let (internalS, v) = self.map(transform).run(externalS)
            return v.run(internalS)
        }
    }
    
    public func apply <S, T> (_ transform: S) -> State<StateParameterType, T> where S: StateType, S.ParameterType == (ParameterType) -> T, S.StateParameterType == StateParameterType {
        return State.zip(self, transform)
            .mapState(from: { ($0, $0) }, to: ffirst)
            .map { value, function in function(value) }
    }
    
    public static func <*> <S, T> (lhs: S, rhs: Self) -> State<StateParameterType, T> where S: StateType, S.ParameterType == (ParameterType) -> T, S.StateParameterType == StateParameterType {
        return State.zip(rhs, lhs)
            .mapState(from: { ($0, $0) }, to: ffirst)
            .map { value, function in function(value) }
    }
    
    public static func pure(_ value: ParameterType) -> State<StateParameterType, ParameterType> {
        return State.unfold { s in (s, value) }
    }
    
    public static func zip <S1, S2> (_ sm1: S1, _ sm2: S2) -> State<(S1.StateParameterType, S2.StateParameterType),(S1.ParameterType, S2.ParameterType)> where S1: StateType, S2: StateType, StateParameterType == (S1.StateParameterType, S2.StateParameterType), ParameterType == (S1.ParameterType, S2.ParameterType) {
        return State.unfold { s1, s2 in
            let (newS1,v1) = sm1.run(s1)
            let (newS2,v2) = sm2.run(s2)
            return ((newS1,newS2),(v1,v2))
        }
    }
}
