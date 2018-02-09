//
//  EntityBasedRepository.swift
//  CoreDomain
//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public class EntityBasedRepository<T: EntityType>: EntityRepositoryType {
    public typealias Entity = T
    
    public init() { }
    
    public func findById(_ id: Entity.ID) -> Entity? {
        return nil
    }
    
    public func findOne(_ predicate: ((Entity) -> Bool)) -> Entity? {
        return nil
    }
    
    public func findAll(_ predicate: ((Entity) -> Bool)) -> [Entity] {
        return []
    }
    
    public func save(id: Entity.ID, entity: Entity) {
        
    }
    
    public func clear() {
        
    }
}
