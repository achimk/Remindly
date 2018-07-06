//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

/**
 DataSource used to describe structure of elements without any sections / number of items manipulations.
 
 # e.g.
 
 let input: [[Int]] = [
    [1, 2, 3],
    [4],
    [5, 6]
 ]
 
 let dataSource = PlainDataSource(sections: input)
 
 print(dataSource.numberOfSections()) // => 3
 print(dataSource.numberOfItems(at: 0)) // => 3
 print(dataSource.numberOfItems(at: 1)) // => 1
 print(dataSource.numberOfItems(at: 2)) // => 2
 
 
 # equivalent:
 
 let ds = DataSource.using(sections: input)
 
 */
public final class PlainDataSource<Element>: DataSource<Element> {

    public var sections: [[Element]]
    
    public override var isEmpty: Bool {
        return makeIterator().next() == nil
    }
    
    public init(element: Element) {
        self.sections = [[element]]
    }
    
    public init(list: [Element]) {
        self.sections = [list]
    }
    
    public init(sections: [[Element]]) {
        self.sections = sections
    }
    
    public override func numberOfSections() -> Int {
        return sections.count
    }
    
    public override func numberOfItemsInSection(_ section: Int) -> Int {
        return section >= 0 && section < sections.count ? sections[section].count : 0
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        return sections[indexPath.section][indexPath.item]
    }
    
    public override func makeIterator() -> AnyIterator<(Element, IndexPath)> {
        return AnyIterator(PlainDataSourceIterator(self))
    }
}
