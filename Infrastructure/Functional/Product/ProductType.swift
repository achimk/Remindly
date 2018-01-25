//
//  ProductType.swift
//  Functional
//
//  Created by Joachim Kret on 05.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// MARK: - ProductType

public protocol ProductType {
    associatedtype FirstType
    associatedtype SecondType
    
    func fold <T> (_ transform: (FirstType, SecondType) -> T) -> T
}

// MARK: - Equatable

extension ProductType where FirstType: Equatable, SecondType: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.fold(fidentity) == rhs.fold(fidentity)
    }
}

// MARK: - Product

extension ProductType {
    
    public var toProduct: Product<FirstType, SecondType> {
        return fold(Product<FirstType, SecondType>.init)
    }
    
    public var first: FirstType {
        return fold { first, _ in first }
    }
    
    public var second: SecondType {
        return fold { _, second in second }
    }
    
    public var unwrap: (FirstType, SecondType) {
        return fold(fidentity)
    }
    
    public func bimap <T, U> (_ onFirst: (FirstType) -> T, _ onSecond: (SecondType) -> U) -> Product<T, U> {
        return fold { first, second in Product<T,U>.init(onFirst(first), onSecond(second)) }
    }
    
    public func mapFirst <T> (_ transform: (FirstType) -> T) -> Product<T, SecondType> {
        return bimap(transform, fidentity)
    }
    
    public func mapSecond <U> (_ transform: (SecondType) -> U) -> Product<FirstType, U> {
        return bimap(fidentity, transform)
    }
}
