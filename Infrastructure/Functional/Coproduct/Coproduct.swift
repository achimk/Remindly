//
//  Coproduct.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public enum Coproduct<A, B>: CoproductType {
    public typealias LeftType = A
    public typealias RightType = B
    
    case left(A)
    case right(B)
    
    public func fold<T>(onLeft: (A) -> T, onRight: (B) -> T) -> T {
        switch self {
        case .left(let a):
            return onLeft(a)
        case .right(let b):
            return onRight(b)
        }
    }
}
