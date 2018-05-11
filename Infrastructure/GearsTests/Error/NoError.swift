//
//  NoError.swift
//  GearsTests
//
//  Created by Joachim Kret on 09.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

/// An “error” that is impossible to construct.
///
/// This can be used to describe `Result`s where failures will never
/// be generated. For example, `Result<Int, NoError>` describes a result that
/// contains an `Int`eger and is guaranteed never to be a `failure`.
public enum NoError: Swift.Error, Equatable {
    public static func ==(lhs: NoError, rhs: NoError) -> Bool {
        return true
    }
}
