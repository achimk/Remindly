//
//  Created by Joachim Kret on 06.07.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension Specification {
    
    public func asSpecification() -> Specification<Candidate> { return self }
}

extension Specification {
    
    public static func using(_ condition: @escaping ((Candidate) -> Bool)) -> Specification<Candidate> {
        
        return AnySpecification(condition)
    }
    
    public static func alwaysSatisfied() -> Specification<Candidate> {
        
        return AnySpecification { _ in return true }
    }
    
    public static func neverSatisfied() -> Specification<Candidate> {
        
        return AnySpecification { _ in return false }
    }
}

extension Specification {
    
    public func and(_ other: Specification<Candidate>) -> Specification<Candidate> {
        
        return AnySpecification {
            self.isSatisfied(by: $0) && other.isSatisfied(by: $0)
        }
    }
    
    public func or(_ other: Specification<Candidate>) -> Specification<Candidate> {
        
        return AnySpecification {
            self.isSatisfied(by: $0) || other.isSatisfied(by: $0)
        }
    }
    
    public func not() -> Specification<Candidate> {
        
        return AnySpecification {
            !self.isSatisfied(by: $0)
        }
    }
}
