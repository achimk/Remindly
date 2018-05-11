//
//  ConditionSpecification.swift
//  CoreDomain
//
//  Created by Joachim Kret on 09.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

final class ConditionSpecification<T>: Specification<T> {
    let condition: ((Entity) -> Bool)
    
    init(_ condition: @escaping ((Entity) -> Bool)) {
        self.condition = condition
    }
    
    override func isSatisfied(by candidate: Entity) -> Bool {
        return condition(candidate)
    }
}
