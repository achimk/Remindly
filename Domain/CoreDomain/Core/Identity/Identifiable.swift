//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol Identifiable {
    associatedtype ID: Equatable
    var identifier: ID { get }
}

extension Identifiable {
    public func toIdentity() -> Identity<ID> {
        return Identity(identifier)
    }
}
