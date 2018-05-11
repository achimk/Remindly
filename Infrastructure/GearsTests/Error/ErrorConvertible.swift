//
//  ErrorConvertible.swift
//  GearsTests
//
//  Created by Joachim Kret on 09.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol ErrorConvertible: Swift.Error {
    static func error(from error: Swift.Error) -> Self
}

extension NSError: ErrorConvertible {
    public static func error(from error: Swift.Error) -> Self {
        func cast<T: NSError>(_ error: Swift.Error) -> T {
            return error as! T
        }
        
        return cast(error)
    }
}
