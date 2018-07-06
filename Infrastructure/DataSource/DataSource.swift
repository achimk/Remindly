//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

/**
 
 Generic DataSource - abstract class used only for subclassing and defintions
 
 e.g.
 let dataSource: DataSource<Int> = ...
 
 */
open class DataSource<T>: DataSourceType {
    
    public typealias Element = T
    
    public var isEmpty: Bool {
        fatalError("DataSource subclass should define isEmpty property!")
    }
    
    public init() { }
    
    open func numberOfSections() -> Int {
        
        return 0
    }
    
    open func numberOfItemsInSection(_ section: Int) -> Int {
        
        return 0
    }
    
    open func item(at indexPath: IndexPath) -> Element {
        
        fatalError("DataSource class can't be used directly!")
    }

    open func makeIterator() -> AnyIterator<(Element, IndexPath)> {
        
        fatalError("DataSource subclass should create dedicated iterator!")
    }
}

extension DataSource {
    
    public func asDataSource() -> DataSource<Element> {
        
        return self
    }
}

