//
//  Created by Joachim Kret on 09.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public class Specification<T>: SatisfiableByCandidate {
    public typealias Candidate = T
    
    public init() { }
    
    public func isSatisfied(by candidate: Candidate) -> Bool {
        abstractMethod()
    }
}
