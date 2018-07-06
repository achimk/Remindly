//
//  Created by Joachim Kret on 09.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol SatisfiableByCandidate {
    associatedtype Candidate
    func isSatisfied(by candidate: Candidate) -> Bool
}
