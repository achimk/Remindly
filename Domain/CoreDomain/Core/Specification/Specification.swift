//
//  Specification.swift
//  CoreDomain
//
//  Created by Joachim Kret on 09.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public class Specification<T>: SatisfiableByCandidate {
    public typealias Entity = T
    
    public init() { }
    
    public func isSatisfied(by candidate: Entity) -> Bool {
        abstractMethod()
    }
}

extension Specification {
    
    public func asSpecification() -> Specification<Entity> { return self }
}

extension Specification {
    
    public static func using(_ condition: @escaping ((Entity) -> Bool)) -> Specification<Entity> {
        return ConditionSpecification(condition)
    }
    
    public static func alwaysSatisfied() -> Specification<Entity> {
        return ConditionSpecification { _ in return true }
    }
    
    public static func neverSatisfied() -> Specification<Entity> {
        return ConditionSpecification { _ in return false }
    }
}

extension Specification {
    
    public func and(_ other: Specification<Entity>) -> Specification<Entity> {
        return ConditionSpecification { self.isSatisfied(by: $0) && other.isSatisfied(by: $0) }
    }
    
    public func or(_ other: Specification<Entity>) -> Specification<Entity> {
        return ConditionSpecification { self.isSatisfied(by: $0) || other.isSatisfied(by: $0) }
    }
    
    public func not() -> Specification<Entity> {
        return ConditionSpecification { !self.isSatisfied(by: $0) }
    }
}
