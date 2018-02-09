//
//  Identity.swift
//  CoreDomain
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class Identity<T: Equatable>: Identifiable {
    public typealias ID = T
    public let identifier: ID
    public init(_ identifier: ID) { self.identifier = identifier }
}

extension Identity: Equatable {
    public static func ==<T>(lhs: Identity<T>, rhs: Identity<T>) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
