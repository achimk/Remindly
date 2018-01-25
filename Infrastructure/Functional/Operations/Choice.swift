//
//  Choice.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public func ffirst <A, B> (_ a: A, _ b: B) -> A {
    return a
}

public func ffirst <A, B, C> (_ a: A, _ b: B, _ c: C) -> A {
    return a
}

public func fsecond <A, B> (_ a: A, _ b: B) -> B {
    return b
}

public func fsecond <A, B, C> (_ a: A, _ b: B, _ c: C) -> B {
    return b
}

public func fthird <A, B, C> (_ a: A, _ b: B, _ c: C) -> C {
    return c
}
