//
//  Created by Joachim Kret on 20.06.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import Foundation

struct PlainDataSourceIterator<T>: IteratorProtocol {
    
    private var baseIterator: AnyIterator<AnyIterator<T>>
    private var currentIterator: AnyIterator<T>?
    private var currentIndexPath = IndexPath(item: 0, section: 0)
    
    init(_ dataSource: PlainDataSource<T>) {
        baseIterator = AnyIterator(dataSource.sections.map { AnyIterator($0.makeIterator()) }.makeIterator())
    }
    
    mutating func next() -> (T, IndexPath)? {
        
        if let item = currentIterator?.next() {
            currentIndexPath = IndexPath(item: currentIndexPath.item + 1, section: currentIndexPath.section)
            return (item, currentIndexPath)
        }
        
        if let next = baseIterator.next() {
            
            if currentIterator == nil {
                currentIndexPath = IndexPath(item: 0, section: 0)
            } else {
                currentIndexPath = IndexPath(item: 0, section: currentIndexPath.section + 1)
            }
            
            currentIterator = next.makeIterator()
            
            if let item = currentIterator?.next() {
                return (item, currentIndexPath)
            }
        }
        
        return nil
    }
}
