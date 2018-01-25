//
//  Monoid+Extensions.swift
//  Functional
//
//  Created by Joachim Kret on 06.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String: Monoid {
    public static var zero: String {
        return ""
    }
    
    public func appending(_ other: String) -> String {
        return self + other
    }
}

extension Int: Monoid {
    public static var zero: Int {
        return 0
    }
    
    public func appending(_ other: Int) -> Int {
        return self + other
    }
}

extension Float: Monoid {
    public static var zero: Float {
        return 0
    }
    
    public func appending(_ other: Float) -> Float {
        return self + other
    }
}

extension Double: Monoid {
    public static var zero: Double {
        return 0
    }
    
    public func appending(_ other: Double) -> Double {
        return self + other
    }
}

extension Array: Monoid {
    public static var zero: Array<Element> {
        return []
    }
    
    public func appending(_ other: Array<Element>) -> Array<Element> {
        var results = self
        results += other
        return results
    }
}

extension Set: Monoid {
    public static var zero: Set<Element> {
        return Set()
    }
    
    public func appending(_ other: Set<Element>) -> Set<Element> {
        var results = self
        results.append(other)
        return results
    }
    
}
