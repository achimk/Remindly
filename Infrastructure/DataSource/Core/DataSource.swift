//
//  DataSource.swift
//  DataSource
//
//  Created by Joachim Kret on 24.01.2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

open class DataSource<T>: DataSourceType {
    public typealias Element = T
    
    public init() { }
    
    open func numberOfSections() -> Int {
        return 0
    }
    
    open func numberOfItems(at section: Int) -> Int {
        return 0
    }
    
    open func item(at indexPath: IndexPath) -> Element {
        abstractMethod()
    }
}

extension DataSource {
    
    public static func pure(_ element: T) -> DataSource<T> {
        return PlainDataSource(element).asDataSource()
    }
    
    public static func of<C: Collection>(_ collection: C) -> DataSource<C.Element> where C.Index == Int, C.IndexDistance == Int, T == C.Element {
        return CollectionDataSource(collection).asDataSource()
    }
    
    public func map<U>(_ f: @escaping (T) -> U) -> DataSource<U> {
        return MapDataSource(source: self, resultSelector: f).asDataSource()
    }
    
    public func merged() -> DataSource<T> {
        var sections: [[T]] = []
        forEach { (indexPath, element, _) in
            if !sections.indices.contains(indexPath.section) { sections.append([]) }
            sections[indexPath.section].append(element)
        }
        
        return PlainDataSource(sections).asDataSource()
    }
    
    public func asDataSource() -> DataSource<T> {
        return self
    }
}

extension DataSource {
    
    public func forEach(_ callback: ((IndexPath, Element, inout Bool) -> Void)) {
        var stop = false
        for section in (0..<numberOfSections()) {
            for item in (0..<numberOfItems(at: section)) {
                let indexPath = IndexPath(item: item, section: section)
                let element = self.item(at: indexPath)
                callback(indexPath, element, &stop)
                if stop { return }
            }
        }
    }
}
