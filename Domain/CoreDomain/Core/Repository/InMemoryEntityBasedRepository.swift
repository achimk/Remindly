//
//  Created by Joachim Kret on 08.02.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public final class InMemoryEntityBasedRepository<T: DomainEntity>: EntityBasedRepository<T> where T.ID: Hashable {
    private var cache: [Entity.ID : Entity] = [:]
    
    public override func findBy(_ id: Entity.ID) -> Entity? {
        return cache[id]
    }
    
    public override func findOne(_ predicate: ((Entity) -> Bool)) -> Entity? {
        return cache.values.filter(predicate).first
    }
    
    public override func findAll(_ predicate: ((Entity) -> Bool)) -> [Entity] {
        return cache.values.filter(predicate)
    }
    
    public override func save(id: Entity.ID, entity: Entity) {
        cache[id] = entity
    }
    
    public override func clear() {
        cache = [:]
    }
}
