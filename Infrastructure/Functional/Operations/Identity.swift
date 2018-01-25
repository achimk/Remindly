//
//  Identity.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public func fidentity <A> (_ a: A) -> A {
    return a
}

public func fidentity <A, B> (_ a: A, _ b: B) -> (A, B) {
    return (a, b)
}

public func fidentity <A, B, C> (_ a: A, _ b: B, _ c: C) -> (A, B, C) {
    return (a, b, c)
}
