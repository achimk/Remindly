//
//  Operators.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

infix operator <*> :AdditionPrecedence

infix operator |>> :AdditionPrecedence

public func |>> <A, B, C> (lhs: @escaping (A) -> B, rhs: @escaping (B) -> C) -> (A) -> C {
        return { a in
            return rhs(lhs(a))
        }
}
