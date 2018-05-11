//
//  SatisfiableByCandidate.swift
//  CoreDomain
//
//  Created by Joachim Kret on 09.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol SatisfiableByCandidate {
    associatedtype Entity
    func isSatisfied(by candidate: Entity) -> Bool
}
