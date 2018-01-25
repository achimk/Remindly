//
//  Product.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public struct Product<A, B>: ProductType {
    public typealias FirstType = A
    public typealias SecondType = B
    
    private let first: A
    private let second: B
    
    public init(_ first: A, _ second: B) {
        self.first = first
        self.second = second
    }
    
    public func fold<T>(_ transform: (A, B) -> T) -> T {
        return transform(first, second)
    }
}
