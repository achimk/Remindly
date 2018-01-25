//
//  AnyMonoid.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public struct AnyMonoid<T> {
    public let zero: T
    public let append: (T, T) -> T
}

extension AnyMonoid where T: Monoid {
    public init() {
        zero = T.zero
        append = T.reducer
    }
}
