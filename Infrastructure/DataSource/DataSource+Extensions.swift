//
//  Created by Joachim Kret on 24.05.2018.
//  Copyright © 2018 eSky. All rights reserved.
//

import Foundation

// MARK: Factories

extension DataSource {
    
    public static func using(element: Element) -> DataSource<Element> {

        return PlainDataSource(element: element)
    }
    
    public static func using(list: [Element]) -> DataSource<Element> {

        return PlainDataSource(list: list)
    }
    
    public static func using(sections: [[Element]]) -> DataSource<Element> {

        return PlainDataSource(sections: sections)
    }
    
    public static func of<C: Collection>(_ collection: C) -> DataSource<C.Element> where C.Index == Int, C.Element == Element {

        return PlainDataSource(list: Array(collection))
    }
    
    public static func flatten(of dataSources: [DataSource<Element>] = []) -> FlatteningDataSource<Element> {
        
        return FlatteningDataSource(dataSources)
    }
    
    public static func combined(of dataSources: [DataSource<Element>] = []) -> CombiningDataSource<Element> {
        
        return CombiningDataSource(dataSources)
    }
}

// MARK: Transformations

extension DataSource {
    
    public func map<U>(_ f: @escaping (Element) -> U) -> DataSource<U> {
        
        return MappingDataSource(source: self, transform: f).asDataSource()
    }
    
    public func flatten() -> DataSource<Element> {
        
        return FlatteningDataSource(self)
    }
    
    public func asPlain() -> PlainDataSource<Element> {
        
        var sections: [[T]] = []
        
        forEach { (indexPath, element, _) in
            
            if !sections.indices.contains(indexPath.section) {
                sections.append([])
            }
            
            sections[indexPath.section].append(element)
        }
        
        return PlainDataSource(sections: sections)
    }
}

// MARK: Others

extension DataSource {
    
    public func forEach(_ callback: ((IndexPath, Element, inout Bool) -> Void)) {

        var stop = false
        
        let seq = AnySequence(makeIterator())
        
        for (element, indexPath) in seq {
            
            callback(indexPath, element, &stop)
            
            if stop { return }
        }
    }
}
