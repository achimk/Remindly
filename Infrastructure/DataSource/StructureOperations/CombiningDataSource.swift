//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

/**
 DataSource used to aggregate other data sources.
 
 # e.g.
 
 let ds1 = DataSource.using(sections: [
    [1, 2],
    [3]
 ])
 
 let ds2 = DataSource.of([4, 5])
 
 let dataSource = CombiningDataSource<Int>()
 
 dataSource.list.append(ds1)
 
 dataSource.list.append(ds2)
 
 print(dataSource.numberOfSections()) // => 3
 print(dataSource.numberOfItems(at: 0)) // => 2
 print(dataSource.numberOfItems(at: 1)) // => 1
 print(dataSource.numberOfItems(at: 2)) // => 2
 
 # equivalent:
 
 let ds = DataSource.combined(of: [ds1, ds2])
 
 */
public final class CombiningDataSource<Element>: DataSource<Element> {

    public var list: [DataSource<Element>]
    
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
        return list.reduce(0, {
            return $0 + $1.numberOfSections()
        })
    }
    
    public override func numberOfItemsInSection(_ section: Int) -> Int {
        
        guard let result = dataSource(at: section) else { return 0 }
        
        return result.dataSource.numberOfItemsInSection(result.section)
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        
        guard let result = dataSource(at: indexPath) else { fatalError("Invalid index path: \(indexPath)") }
        
        return result.dataSource.item(at: result.indexPath)
    }
    
    public override func makeIterator() -> AnyIterator<(Element, IndexPath)> {
        return AnyIterator(CombiningDataSourceIterator(self))
    }
    
    private func dataSource(at section: Int) -> (dataSource: DataSource<Element>, section: Int)? {
        
        guard section >= 0 else { return nil }
        
        var offset = 0
        
        for dataSource in list {
            let sectionsCount = dataSource.numberOfSections()
            
            if section >= offset && section < offset + sectionsCount {
                return (dataSource, (section - offset))
            }
            
            offset += sectionsCount
        }
        
        return nil
        
    }
    
    private func dataSource(at indexPath: IndexPath) -> (dataSource: DataSource<Element>, indexPath: IndexPath)? {
        
        guard indexPath.item >= 0 else { return nil }
        
        if let info = dataSource(at: indexPath.section) {
            let count = info.dataSource.numberOfItemsInSection(info.section)
        
            if indexPath.item < count {
                return (info.dataSource, IndexPath(item: indexPath.item, section: info.section))
            }
        }
        
        return nil
    }
}
