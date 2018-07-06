//
//  Created by Joachim Kret on 20.06.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import Foundation

struct MappingDataSourceIterator<T, U>: IteratorProtocol {

    private var iterator: AnyIterator<(T, IndexPath)>
    private let transform: (T) -> U

    init(_ dataSource: MappingDataSource<T, U>) {
        self.iterator = AnyIterator(dataSource.source.makeIterator())
        self.transform = dataSource.transform
    }
    
    mutating func next() -> (U, IndexPath)? {
        
        if let (item, indexPath) = iterator.next() {
            return (transform(item), indexPath)
        }
        
        return nil
    }
}
