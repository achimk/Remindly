//
//  Constant.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public func fconstant <A> (_ a : A) -> () -> A {
    return { a }
}

public func fconstant <A, B> (_ a : A) -> (B) -> A {
    return { _ in a }
}

public func fconstant <A, B, C> (_ a : A) -> (B, C) -> A {
    return { _, _ in a }
}
