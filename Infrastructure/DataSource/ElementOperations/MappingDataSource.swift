//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

/**
 DataSource used to map items from one type `S` to other `R`.
 
 # e.g.
 
 let input: [Int] = [1, 2, 3]
 
 let source = PlainDataSource(list: input)
 
 let transform: (Int) -> String { value in
    return "Item \(value)"
 }
 
 let dataSource = MappingDataSource(source: source, transform: transform)

 
 # equivalent:
 
 let ds = DataSource.of(input).map(transform)
 
 */
public final class MappingDataSource<Source, Element>: DataSource<Element> {

    public let source: DataSource<Source>
    
    public let transform: ((Source) -> Element)
    
    public override var isEmpty: Bool {
        return source.isEmpty
    }
    
    public init(source: DataSource<Source>, transform: @escaping ((Source) -> Element)) {
        self.source = source
        self.transform = transform
    }
    
    public override func numberOfSections() -> Int {
        return source.numberOfSections()
    }
    
    public override func numberOfItemsInSection(_ section: Int) -> Int {
        return source.numberOfItemsInSection(section)
    }
    
    public override func item(at indexPath: IndexPath) -> Element {
        return transform(source.item(at: indexPath))
    }
    
    public override func makeIterator() -> AnyIterator<(Element, IndexPath)> {
        return AnyIterator(MappingDataSourceIterator(self))
    }
}
