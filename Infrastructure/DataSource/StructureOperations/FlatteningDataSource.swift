//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

/**
 DataSource used to aggregate and flatten listed data sources into one section.
 
 # e.g.
 
 let ds1 = DataSource.using(sections: [
    [1, 2],
    [3]
 ])
 
 let ds2 = DataSource.of([4, 5])
 
 let dataSource = FlatteningDataSource<Int>()
 
 dataSource.list.append(ds1)
 
 dataSource.list.append(ds2)
 
 print(dataSource.numberOfSections()) // => 1
 print(dataSource.numberOfItems(at: 0)) // => 5
 
 # equivalent:
 
 let ds = DataSource.flatten(of: [ds1, ds2])
 
 */
public final class FlatteningDataSource<Element>: DataSource<Element> {
    
    public var list: [DataSource<Element>]
    
    public var count: Int {
        var count = 0
        for dataSource in list {
            for section in 0 ..< dataSource.numberOfSections() {
                count = count + dataSource.numberOfItemsInSection(section)
            }
        }
        return count
    }
    
    public override var isEmpty: Bool {
        for dataSource in list {
            if !dataSource.isEmpty { return false }
        }
        
        return true
    }
    
    public init(_ dataSource: DataSource<Element>) {
        self.list = [dataSource]
    }
    
    public init(_ list: [DataSource<Element>] = []) {
        self.list = list
    }
    
    public override func numberOfSections() -> Int {
        return isEmpty ? 0 : 1
    }
    
    public override func numberOfItemsInSection(_ section: Int) -> Int {
        return section == 0 ? count : 0
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        
        guard let result = dataSource(at: indexPath) else { fatalError("Invalid index path: \(indexPath)") }
        
        return result.dataSource.item(at: result.indexPath)
    }
    
    public override func makeIterator() -> AnyIterator<(Element, IndexPath)> {
        return AnyIterator(FlatteningDataSourceIterator(self))
    }
    
    private func dataSource(at indexPath: IndexPath) -> (dataSource: DataSource<Element>, indexPath: IndexPath)? {
        
        guard indexPath.section == 0 else { return nil }
        
        var offset: Int = 0
        for dataSource in list {
            for section in 0 ..< dataSource.numberOfSections() {
                for row in 0 ..< dataSource.numberOfItemsInSection(section) {
                    if offset == indexPath.item {
                        let localIndexPath = IndexPath(row: row, section: section)
                        return (dataSource, localIndexPath)
                    }
                    offset = (offset + 1)
                }
            }
        }
        
        return nil
    }
}
