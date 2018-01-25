//
//  Monoid.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol Monoid {
    static var zero: Self { get }
    func appending(_ other: Self) -> Self
}

extension Monoid {
    public mutating func append(_ other: Self) {
        self = self.appending(other)
    }
    
    public static var reducer: (Self, Self) -> Self {
        return { x, y in x.appending(y) }
    }
}
