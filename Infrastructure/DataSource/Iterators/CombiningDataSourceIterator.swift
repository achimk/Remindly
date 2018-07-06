//
//  Created by Joachim Kret on 20.06.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import Foundation

struct CombiningDataSourceIterator<T>: IteratorProtocol {
    
    private var offset: Int = 0
    private var lastIndexPath = IndexPath(item: 0, section: 0)
    private var currentIterator: AnyIterator<(T, IndexPath)>?
    private var iterators: [AnyIterator<(T, IndexPath)>]
    
    init(_ dataSource: CombiningDataSource<T>) {
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
        
        if lastIndexPath.section != indexPath.section
            || lastIndexPath.item > indexPath.item {
            
            offset = offset.advanced(by: 1)
        }
        
        lastIndexPath = indexPath
        
        return IndexPath(item: indexPath.item, section: offset)
    }
}
