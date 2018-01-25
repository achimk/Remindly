//
//  Combinations.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public func fcompose <A, B, C> (_ first: @escaping (A) -> B, _ second: @escaping (B) -> C) -> (A) -> C {
    return { second(first($0)) }
}

public func fcompose <A, B, C> (_ first: @escaping (A) throws -> B, _ second: @escaping (B) -> C) -> (A) throws -> C {
    return { try second(first($0)) }
}

public func fcompose <A, B, C> (_ first: @escaping (A) -> B, _ second: @escaping (B) throws -> C) -> (A) throws -> C {
    return { try second(first($0)) }
}

public func fcompose <A, B, C> (_ first: @escaping (A) throws -> B, _ second: @escaping (B) throws -> C) -> (A) throws -> C {
    return { try second(first($0)) }
}
