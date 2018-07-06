//
//  Created by Joachim Kret on 20.06.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import Foundation

struct FlatteningDataSourceIterator<T>: IteratorProtocol {
    
    private var offset: Int = 0
    private var currentIterator: AnyIterator<(T, IndexPath)>?
    private var iterators: [AnyIterator<(T, IndexPath)>]
    
    init(_ dataSource: FlatteningDataSource<T>) {
        iterators = dataSource.list.map { AnyIterator($0.makeIterator()) }
    }
    
    mutating func next() -> (T, IndexPath)? {
        
        guard let (item, indexPath) = dropNext() else { return nil }
        
        return (item, updatedWithOffset(for: indexPath))
    }
    
    private mutating func dropFirst() -> (T, IndexPath)? {
        
        if iterators.isEmpty { return nil }
        
        currentIterator = iterators.first
        iterators = Array(iterators.dropFirst())
        
        return currentIterator?.next() ?? dropFirst()
    }
    
    private mutating func dropNext() -> (T, IndexPath)? {
        
        if let item = currentIterator?.next() { return item }
        
        return dropFirst()
    }
    
    private mutating func updatedWithOffset(for indexPath: IndexPath) -> IndexPath {
        
        let indexPath = IndexPath(item: offset, section: 0)
        
        offset = offset.advanced(by: 1)
        
        return indexPath
    }
}
