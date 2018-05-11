//
//  EntityBasedRepository.swift
//  CoreDomain
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public class EntityBasedRepository<T: Identifiable>: DomainRepositoryType {
    public typealias Entity = T
    
    public init() { }
    
    public func findBy(_ id: Entity.ID) -> Entity? {
        abstractMethod()
    }
    
    public func findOne(_ predicate: ((Entity) -> Bool)) -> Entity? {
        abstractMethod()
    }
    
    public func findAll(_ predicate: ((Entity) -> Bool)) -> [Entity] {
        abstractMethod()
    }
    
    public func save(id: Entity.ID, entity: Entity) {
        abstractMethod()
    }
    
    public func clear() {
        abstractMethod()
    }
}

extension EntityBasedRepository {
    
    public func findBy(_ identity: Identity<Entity.ID>) -> Entity? {
        return findBy(identity.rawValue)
    }
    
    public func save(id: Identity<Entity.ID>, entity: Entity) {
        save(id: id.rawValue, entity: entity)
    }
}
