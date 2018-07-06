//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class Identity<T: Equatable> {
    public typealias ID = T
    public let rawValue: ID
    public init(_ rawValue: ID) { self.rawValue = rawValue }
}

extension Identity: Equatable {
    public static func ==<T>(lhs: Identity<T>, rhs: Identity<T>) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
