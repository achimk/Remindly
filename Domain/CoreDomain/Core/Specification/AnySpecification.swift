//
//  Created by Joachim Kret on 09.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class AnySpecification<Candidate>: Specification<Candidate> {
    
    private let condition: ((Candidate) -> Bool)
    
    public init(_ condition: @escaping ((Candidate) -> Bool)) {
        self.condition = condition
    }
    
    public override func isSatisfied(by candidate: Candidate) -> Bool {
        return condition(candidate)
    }
}
