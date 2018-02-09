//
//  EntityRepositoryType.swift
//  CoreDomain
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public protocol EntityRepositoryType: DomainRepositoryType {
    associatedtype Entity: EntityType
    
    func findById(_ id: Entity.ID) -> Entity?
    func findOne(_ predicate: ((Entity) -> Bool)) -> Entity?
    func findAll(_ predicate: ((Entity) -> Bool)) -> [Entity]
    
    func save(id: Entity.ID, entity: Entity)
    
    func clear()
}
